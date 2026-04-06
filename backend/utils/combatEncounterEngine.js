const db = require('../config/db');
const { calculateCombat } = require('./gameEngine');

const getCounterDamage = (monster, player) => {
    return Math.max(
        1,
        Math.floor(Number(monster.base_attack || 5) - (Number(player.defense || 0) / 3))
    );
};

const loadOrCreateEncounter = async (player) => {
    let activeMonster = null;
    let isNewEncounter = false;

    const [activeFights] = await db.execute(`
        SELECT a.encounter_id, a.dynamic_level, a.current_hp, a.max_hp, m.*
        FROM active_encounters a
        JOIN master_npcs m ON a.npc_id = m.id
        WHERE a.life_id = ?
    `, [player.life_id]);

    if (activeFights.length > 0) {
        activeMonster = activeFights[0];
    } else {
        const [spawns] = await db.execute(`
            SELECT m.* 
            FROM zone_spawns z 
            JOIN master_npcs m ON z.npc_id = m.id 
            WHERE z.zone_name = ? 
              AND RAND() * 100 <= z.spawn_chance
            LIMIT 1
        `, [player.current_location]);

        if (spawns.length > 0) {
            const m = spawns[0];
            const dLevel = Math.max(
                1,
                Number(player.current_level || 1) + Math.floor(Math.random() * 3) - 1
            );
            const dHp = Number(m.base_hp || 1) + (dLevel * 10);

            const [insertEnc] = await db.execute(`
                INSERT INTO active_encounters (life_id, npc_id, dynamic_level, current_hp, max_hp)
                VALUES (?, ?, ?, ?, ?)
            `, [player.life_id, m.id, dLevel, dHp, dHp]);

            activeMonster = {
                ...m,
                encounter_id: insertEnc.insertId,
                dynamic_level: dLevel,
                current_hp: dHp,
                max_hp: dHp
            };

            isNewEncounter = true;
        }
    }

    return { activeMonster, isNewEncounter };
};

const resolveCombatEncounter = async ({ player, action, engineNotice = "" }) => {
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const { activeMonster, isNewEncounter } = await loadOrCreateEncounter(player);

    if (!activeMonster) {
        return {
            player,
            engineNotice,
            monsterContext,
            monsterButtons,
            monsterImageUrl,
            activeMonster: null
        };
    }

    monsterImageUrl = activeMonster.npc_image || null;

    if (action.startsWith("Attack")) {
        const result = calculateCombat(player, activeMonster);

        player.xp = Number(player.xp || 0) + Number(result.xpGained || 0);
        player.sp = Math.max(0, Number(player.sp || 0) - Number(result.spCost || 0));
        player.hunger = Math.max(0, Number(player.hunger || 0) - Number(result.hungerCost || 0));

        if (result.isMonsterDead) {
            engineNotice += ` [COMBAT_LOG: Action: Strike vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${result.damageDealt}. Status: TARGET_ELIMINATED. XP: ${result.xpGained}.]`;

            await db.execute(
                'DELETE FROM active_encounters WHERE encounter_id = ?',
                [activeMonster.encounter_id]
            );

            monsterContext = `[ENCOUNTER CLEARED] The corpse of the ${activeMonster.name} lies before you. `;
        } else {
            engineNotice += ` [COMBAT_LOG: Action: Strike vs Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. DMG: ${result.damageDealt}. Enemy HP: ${result.monsterRemainingHp}/${activeMonster.max_hp}. Status: COUNTER_ATTACK_IMMINENT. SP Cost: ${result.spCost}. Hunger Cost: ${result.hungerCost}.]`;

            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            engineNotice += ` [COUNTER_LOG: ${activeMonster.name} retaliates. Player Damage Taken: ${counterDamage}.]`;

            await db.execute(
                'UPDATE active_encounters SET current_hp = ? WHERE encounter_id = ?',
                [result.monsterRemainingHp, activeMonster.encounter_id]
            );

            monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank}). Enemy HP: ${result.monsterRemainingHp}/${activeMonster.max_hp}]. `;
            monsterButtons.push(`Attack the ${activeMonster.name}`);
            monsterButtons.push(`Attempt to Flee from the ${activeMonster.name}`);
        }
    } else if (action.startsWith("Attempt to Flee")) {
        if (Math.random() > 0.5) {
            engineNotice += ` [COMBAT_LOG: Escape successful. You broke line of sight.]`;

            await db.execute(
                'DELETE FROM active_encounters WHERE encounter_id = ?',
                [activeMonster.encounter_id]
            );

            monsterContext = `[FLED ENCOUNTER]`;
        } else {
            engineNotice += ` [COMBAT_LOG: Escape failed. The Lvl ${activeMonster.dynamic_level} ${activeMonster.name} blocks your path.]`;

            const counterDamage = getCounterDamage(activeMonster, player);
            player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

            engineNotice += ` [COUNTER_LOG: ${activeMonster.name} punishes your escape attempt. Player Damage Taken: ${counterDamage}.]`;

            monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
            monsterButtons.push(`Attack the ${activeMonster.name}`);
            monsterButtons.push(`Attempt to Flee from the ${activeMonster.name}`);
        }
    } else if (isNewEncounter) {
        monsterContext = `[ENCOUNTER: WILD Lvl ${activeMonster.dynamic_level} ${activeMonster.name} (${activeMonster.danger_rank}). Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. ${activeMonster.description}. `;
        monsterButtons.push(`Attack the ${activeMonster.name}`);
        monsterButtons.push(`Attempt to Flee from the ${activeMonster.name}`);
    } else {
        const counterDamage = getCounterDamage(activeMonster, player);
        player.hp = Math.max(0, Number(player.hp || 0) - counterDamage);

        engineNotice += ` [COMBAT_LOG: Player attempted a custom action: "${action}". The Lvl ${activeMonster.dynamic_level} ${activeMonster.name} seized the opening and attacked. Player Damage Taken: ${counterDamage}.]`;

        monsterContext = `[IN COMBAT: Lvl ${activeMonster.dynamic_level} ${activeMonster.name}. Enemy HP: ${activeMonster.current_hp}/${activeMonster.max_hp}]. `;
        monsterButtons.push(`Attack the ${activeMonster.name}`);
        monsterButtons.push(`Attempt to Flee from the ${activeMonster.name}`);
    }

    return {
        player,
        engineNotice,
        monsterContext,
        monsterButtons,
        monsterImageUrl,
        activeMonster
    };
};

module.exports = {
    resolveCombatEncounter
};