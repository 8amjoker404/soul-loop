// utils/worldEngine.js
const db = require('../config/db');

const shuffleArray = (arr = []) => {
    const copy = [...arr];
    for (let i = copy.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [copy[i], copy[j]] = [copy[j], copy[i]];
    }
    return copy;
};

const uniqueStrings = (arr = []) => {
    return [...new Set(arr.filter(Boolean).map(item => String(item).trim()))];
};

const scanWorldContext = async (player, userId) => {
    const [souls] = await db.execute(`
        SELECT 
            u.username,
            c.user_id,
            c.species,
            c.current_level,
            c.current_location,
            c.pos_x,
            c.pos_y
        FROM current_life c
        JOIN users u ON c.user_id = u.id
        WHERE c.is_alive = 1
          AND c.user_id != ?
          AND c.current_location = ?
    `, [userId, player.current_location]);

    let pvpContext = "";
    let pvpButtons = [];
    let nearbyPlayers = [];

    if (souls.length > 0) {
        const exactTile = [];
        const nearbyArea = [];
        const sensedArea = [];

        for (const soul of souls) {
            const dx = Math.abs(Number(soul.pos_x || 0) - Number(player.pos_x || 0));
            const dy = Math.abs(Number(soul.pos_y || 0) - Number(player.pos_y || 0));
            const distance = dx + dy;

            const soulData = {
                username: soul.username,
                user_id: soul.user_id,
                species: soul.species,
                current_level: Number(soul.current_level || 1),
                current_location: soul.current_location,
                pos_x: Number(soul.pos_x || 0),
                pos_y: Number(soul.pos_y || 0),
                distance
            };

            if (dx === 0 && dy === 0) {
                exactTile.push(soulData);
            } else if (distance <= 3) {
                nearbyArea.push(soulData);
            } else {
                sensedArea.push(soulData);
            }
        }

        nearbyPlayers = [...exactTile, ...nearbyArea, ...sensedArea];

        const exactNames = exactTile.map(p => p.username);
        const nearbyNames = nearbyArea.map(p => p.username);
        const sensedNames = sensedArea.map(p => p.username);

        const contextParts = [];

        if (exactTile.length > 0) {
            contextParts.push(
                `${exactTile.length} soul(s) stand on your exact tile (${exactNames.join(', ')})`
            );
        }

        if (nearbyArea.length > 0) {
            contextParts.push(
                `${nearbyArea.length} soul(s) move nearby (${nearbyNames.join(', ')})`
            );
        }

        if (sensedArea.length > 0) {
            if (sensedArea.length === 1) {
                contextParts.push(
                    `you sense another soul deeper within ${player.current_location} (${sensedNames[0]})`
                );
            } else {
                contextParts.push(
                    `you sense ${sensedArea.length} more distant souls deeper within ${player.current_location} (${sensedNames.join(', ')})`
                );
            }
        }

        if (contextParts.length > 0) {
            pvpContext = `[PVP DETECTED: ${contextParts.join('. ')}.]. `;
        }

        const actionPool = [];

        // exact tile = direct actions
        for (const target of exactTile) {
            actionPool.push(`Challenge ${target.username} to a Duel`);
            actionPool.push(`Attack ${target.username}`);
            actionPool.push(`Observe ${target.username} carefully`);
            actionPool.push(`Threaten ${target.username}`);
            actionPool.push(`Speak to ${target.username}`);
        }

        // nearby area = close movement actions
        for (const target of nearbyArea) {
            actionPool.push(`Approach ${target.username}`);
            actionPool.push(`Track ${target.username}`);
            actionPool.push(`Observe ${target.username} from afar`);
            actionPool.push(`Hide from ${target.username}`);
            actionPool.push(`Avoid ${target.username} for now`);
        }

        // sensed area = indirect awareness actions
        if (sensedArea.length > 0) {
            actionPool.push(`Listen for movement`);
            actionPool.push(`Search for hostile intent`);
            actionPool.push(`Follow the strange presence`);
            actionPool.push(`Move carefully toward the danger`);
            actionPool.push(`Stay hidden and sense the area`);
        }

        // group actions
        if (nearbyPlayers.length > 1) {
            actionPool.push(`Observe all nearby souls`);
            actionPool.push(`Threaten everyone nearby`);
            actionPool.push(`Hide from everyone nearby`);
            actionPool.push(`Approach the group carefully`);
        }

        // fallback awareness actions
        actionPool.push(`Stay alert and do nothing`);
        actionPool.push(`Scan the surroundings`);
        actionPool.push(`Listen to the silence`);

        pvpButtons = shuffleArray(uniqueStrings(actionPool)).slice(0, 4);
    }

    const [news] = await db.execute(`
        SELECT status_log
        FROM reincarnated_npcs
        WHERE status_log IS NOT NULL
          AND TRIM(status_log) != ''
        ORDER BY RAND()
        LIMIT 1
    `);

    let worldLore = "";

    if (news.length > 0) {
        const rumor = String(news[0].status_log).trim();
        worldLore = `[GLOBAL NEWS: ${rumor}]. `;
    }

    return {
        pvpContext,
        pvpButtons,
        worldLore,
        nearbyPlayers
    };
};

module.exports = { scanWorldContext };