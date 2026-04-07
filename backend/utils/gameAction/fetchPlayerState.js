// backend/utils/gameAction/fetchPlayerState.js
const db = require('../../config/db');

function parsePermanentSkillNames(raw) {
    if (raw == null || raw === '') return [];
    if (Array.isArray(raw)) return raw.map(String).filter(Boolean);
    if (typeof raw === 'string') {
        try {
            const parsed = JSON.parse(raw);
            return Array.isArray(parsed) ? parsed.map(String).filter(Boolean) : [];
        } catch {
            return [];
        }
    }
    return [];
}

/**
 * Loads `master_skills` rows for names in `users.permanent_skills` and sets
 * `player.active_skills` / `player.passive_skills` (detailed objects for AI & combat).
 */
async function enrichPlayerWithMasterSkills(player) {
    const names = parsePermanentSkillNames(player.permanent_skills);
    if (names.length === 0) {
        player.active_skills = [];
        player.passive_skills = [];
        return player;
    }

    const placeholders = names.map(() => '?').join(',');
    const [rows] = await db.execute(
        `SELECT id, name, description, karma_cost, skill_type, sp_cost
         FROM master_skills
         WHERE name IN (${placeholders})`,
        names
    );

    const active = [];
    const passive = [];

    for (const row of rows) {
        const detail = {
            id: row.id,
            name: row.name,
            description: row.description || '',
            karma_cost: Math.max(0, Math.floor(Number(row.karma_cost) || 0)),
            skill_type: row.skill_type,
            sp_cost: Math.max(0, Math.floor(Number(row.sp_cost) || 0))
        };
        const t = String(row.skill_type || '').toUpperCase();
        if (t === 'ACTIVE') {
            active.push(detail);
        } else {
            passive.push(detail);
        }
    }

    player.active_skills = active;
    player.passive_skills = passive;
    return player;
}

async function fetchActivePlayerState(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills, u.karma
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        JOIN soul_library s ON c.user_id = s.user_id
        WHERE c.user_id = ? AND c.is_alive = 1
    `, [userId]);

    if (!playerRows.length) {
        throw new Error("No active life found.");
    }

    await enrichPlayerWithMasterSkills(playerRows[0]);
    return playerRows[0];
}

/**
 * Most recent life row (alive or dead). Used for Soul Stream / reincarnation gates.
 */
async function fetchLatestLifeForUser(userId) {
    const [playerRows] = await db.execute(`
        SELECT c.*, u.username, u.system_voice, u.permanent_skills, u.karma
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        JOIN soul_library s ON c.user_id = s.user_id
        WHERE c.user_id = ?
        ORDER BY c.life_id DESC
        LIMIT 1
    `, [userId]);

    if (!playerRows.length) {
        return null;
    }

    await enrichPlayerWithMasterSkills(playerRows[0]);
    return playerRows[0];
}

module.exports = {
    fetchActivePlayerState,
    fetchLatestLifeForUser,
    enrichPlayerWithMasterSkills,
    parsePermanentSkillNames
};
