/**
 * gameEngine.js — combat math + level progression
 */

const { clampSp } = require('./survivalEngine');

const calculateCombat = (player, monster, options = {}) => {
    const isSkill = !!options.isSkill;
    const spCost = isSkill ? 12 : 4;
    const hungerCost = isSkill ? 4 : 2;

    const levelDiff = player.current_level - monster.base_level;
    let xpMultiplier = 1.0;

    if (levelDiff > 5) xpMultiplier = 0.5;
    if (levelDiff > 10) xpMultiplier = 0.1;
    if (levelDiff > 20) xpMultiplier = 0.0;

    const hungerFactor = player.hunger < 10 ? 0.5 : 1.0;

    const rawDamage =
        (player.offense * player.current_level - monster.base_defense / 2) * hungerFactor;
    const damageDealt = Math.max(1, Math.floor(rawDamage));

    const isMonsterDead = monster.base_hp - damageDealt <= 0;

    const rankXP = { F: 20, E: 50, D: 100, C: 250, B: 500, A: 1000, S: 5000 };
    const baseXP = isMonsterDead ? rankXP[monster.danger_rank] || 20 : 5;

    const xpGained = Math.floor(baseXP * xpMultiplier);

    return {
        damageDealt,
        isMonsterDead,
        xpGained,
        monsterRemainingHp: Math.max(0, monster.base_hp - damageDealt),
        spCost,
        hungerCost
    };
};

/**
 * Threshold is `next_level_xp` (API may alias as `next_mark` on the player object).
 * Supports multiple level-ups in one call. Persists to `current_life` when `db` is provided.
 *
 * @returns {Promise<{ player: object, levelUpNotice: string }>}
 */
async function checkLevelUp(player, db) {
    if (!player) {
        return { player, levelUpNotice: '' };
    }

    let threshold = Math.max(
        1,
        Math.floor(Number(player.next_level_xp ?? player.next_mark) || 100)
    );
    player.next_level_xp = threshold;
    if (player.next_mark !== undefined) {
        player.next_mark = threshold;
    }

    const notices = [];
    let xp = Math.floor(Number(player.xp) || 0);

    while (xp >= threshold) {
        const oldMark = threshold;

        player.current_level = Math.floor(Number(player.current_level) || 1) + 1;
        xp -= oldMark;
        player.xp = xp;

        threshold = Math.max(1, Math.floor(oldMark * 1.2));
        player.next_level_xp = threshold;
        if (player.next_mark !== undefined) {
            player.next_mark = threshold;
        }

        player.attribute_points = Math.floor(Number(player.attribute_points) || 0) + 5;
        player.skill_points = Math.floor(Number(player.skill_points) || 0) + 2;

        const maxHp = Math.max(1, Math.floor(Number(player.max_hp) || 1));
        const maxMp = Math.max(0, Math.floor(Number(player.max_mp) || 0));
        const maxSp = Math.max(1, Math.floor(Number(player.max_sp) || 100));

        player.hp = maxHp;
        player.mp = maxMp;
        player.sp = clampSp(player, maxSp);

        notices.push(
            `[SYSTEM_LEVEL_UP]: Reached Level ${player.current_level}! +5 Attribute Points, +2 Skill Points. HP/MP/SP fully restored. Next tier requires ${threshold} XP.`
        );
    }

    const levelUpNotice = notices.length ? notices.join(' ') : '';

    if (notices.length > 0 && db && player.life_id) {
        await db.execute(
            `UPDATE current_life SET
                xp = ?,
                current_level = ?,
                next_level_xp = ?,
                attribute_points = ?,
                skill_points = ?,
                hp = ?,
                mp = ?,
                sp = ?
             WHERE life_id = ?`,
            [
                player.xp,
                player.current_level,
                player.next_level_xp,
                player.attribute_points,
                player.skill_points,
                player.hp,
                player.mp,
                player.sp,
                player.life_id
            ]
        );
    }

    return { player, levelUpNotice };
}

module.exports = { calculateCombat, checkLevelUp };
