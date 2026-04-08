/**
 * Plot beats stored in `story_milestones`; per-user progress in `user_story_milestones`.
 * Run `backend/sql/story_and_context.sql` if tables are missing.
 */

/**
 * @param {import('mysql2/promise').Pool} db
 * @param {number} userId
 * @param {object} player current_life row (+ joins ok)
 * @returns {Promise<{ story_injection: string | null, milestones_fired: Array<{ code: string, content: string }> }>}
 */
async function resolvePendingMilestones(db, userId, player) {
    const level = Math.floor(Number(player.current_level) || 1);
    const loc = String(player.current_location || '').trim();

    let pending;
    try {
        const [rows] = await db.execute(
            `SELECT m.milestone_id, m.code, m.content
             FROM story_milestones m
             WHERE (m.min_level IS NULL OR ? >= m.min_level)
               AND (m.location_id IS NULL OR m.location_id = ?)
               AND NOT EXISTS (
                 SELECT 1 FROM user_story_milestones u
                 WHERE u.user_id = ? AND u.milestone_id = m.milestone_id
               )
             ORDER BY m.sort_order ASC, m.milestone_id ASC`,
            [level, loc, userId]
        );
        pending = rows;
    } catch (err) {
        if (err.code === 'ER_NO_SUCH_TABLE') {
            return { story_injection: null, milestones_fired: [] };
        }
        throw err;
    }

    if (!pending.length) {
        return { story_injection: null, milestones_fired: [] };
    }

    const conn = await db.getConnection();

    try {
        await conn.beginTransaction();

        const fired = [];
        for (const row of pending) {
            await conn.execute(
                'INSERT INTO user_story_milestones (user_id, milestone_id) VALUES (?, ?)',
                [userId, row.milestone_id]
            );
            fired.push({
                code: row.code,
                content: String(row.content || '').trim()
            });
        }

        await conn.commit();

        const story_injection = fired.map((f) => f.content).filter(Boolean).join('\n\n') || null;
        return { story_injection, milestones_fired: fired };
    } catch (err) {
        await conn.rollback();
        if (err.code === 'ER_NO_SUCH_TABLE') {
            return { story_injection: null, milestones_fired: [] };
        }
        throw err;
    } finally {
        conn.release();
    }
}

module.exports = { resolvePendingMilestones };
