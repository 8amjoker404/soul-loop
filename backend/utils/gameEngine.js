/**
 * gameEngine.js
 * Integrated with Survival Vitals (Hunger/SP)
 */

// In utils/gameEngine.js
const calculateCombat = (player, monster) => {
    const hungerFactor = player.hunger <= 0 ? 0.5 : 1.0;

    const rawDamage =
        ((Number(player.offense) * Number(player.current_level)) - (Number(monster.base_defense || 5) / 2)) *
        hungerFactor;

    const damageDealt = Math.max(1, Math.floor(rawDamage));

    // CRITICAL FIX: Read current_hp from the active encounter, not the base template
    const monsterCurrentHp = Number(monster.current_hp);
    const monsterRemainingHp = Math.max(0, monsterCurrentHp - damageDealt);
    const isMonsterDead = monsterRemainingHp <= 0;

    const combatSpCost = 15;
    const combatHungerCost = 8;

    const rankXP = { F: 20, E: 50, D: 100, C: 250, B: 500, A: 1000, S: 5000 };
    // Multiply XP by the monster's dynamic level to make harder fights more rewarding
    const xpGained = isMonsterDead ? ((rankXP[monster.danger_rank] || 20) * Number(monster.dynamic_level || 1)) : 5;

    return {
        damageDealt,
        isMonsterDead,
        xpGained,
        spCost: combatSpCost,
        hungerCost: combatHungerCost,
        monsterRemainingHp
    };
};

const processLevelUp = (player) => {
    if (Number(player.xp) < Number(player.next_level_xp)) {
        return { leveledUp: false };
    }

    const newLevel = Number(player.current_level) + 1;
    const hpGain = 15;
    const mpGain = 10;
    const statGain = 3;

    return {
        leveledUp: true,
        current_level: newLevel,
        max_hp: Number(player.max_hp) + hpGain,
        hp: Number(player.max_hp) + hpGain, // full heal
        max_mp: Number(player.max_mp) + mpGain,
        mp: Number(player.max_mp) + mpGain, // optional full mana refill
        offense: Number(player.offense) + statGain,
        defense: Number(player.defense) + statGain,
        speed: Number(player.speed) + statGain,
        next_level_xp: Math.floor(Number(player.next_level_xp) * 2.5),
        systemLog: `[SYSTEM_EVOLUTION]: Leveled to ${newLevel}. Strength grows.`
    };
};

module.exports = { calculateCombat, processLevelUp };