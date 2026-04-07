// utils/cheatEngine.js
const db = require('../config/db');

const handleAdminCheat = async (action, player, userId) => {
    const normalizedAction = String(action || '').trim().toLowerCase();

    if (!normalizedAction) {
        return { isCheat: false };
    }

    if (normalizedAction === "i devour the system") {
        const cheatSkills = ["Immortality LV 10", "System Override", "Instant Death Magic"];
        const cheatChoices = ["Destroy the Labyrinth", "Summon a Dragon", "Teleport to the Surface"];

        await db.execute(
            `UPDATE current_life SET 
                hp = 9999,
                max_hp = 9999,
                mp = 9999,
                max_mp = 9999,
                current_level = 100,
                offense = 999,
                defense = 999
             WHERE life_id = ?`,
            [player.life_id]
        );

        await db.execute('UPDATE users SET permanent_skills = ? WHERE id = ?', [
            JSON.stringify(cheatSkills),
            userId
        ]);

        const godMsg = `[CRITICAL WARNING] FIREWALL BREACHED. Administrator status restored. Matrix absorbed.`;

        return {
            isCheat: true,
            response: {
                status: "ALIVE",
                stats: {
                    hp: 9999,
                    mp: 9999,
                    level: 100,
                    xp: 0,
                    next_mark: 99999
                },
                skills: cheatSkills,
                choices: cheatChoices,
                system_output: godMsg
            }
        };
    }

    return { isCheat: false };
};

module.exports = { handleAdminCheat };