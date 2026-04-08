/**
 * Rich "Search / look around" context: location hidden lore + reincarnated_npcs at this zone.
 */

function isSearchLikeAction(action) {
    const t = String(action || '').trim().toLowerCase();
    if (!t) return false;
    // Standalone verbs (Search / Look / Scan) and common phrases
    if (/^search\b/i.test(t)) return true;
    if (/^look\b/i.test(t)) return true;
    if (/^scan\b/i.test(t)) return true;
    if (/\blook around\b/i.test(t)) return true;
    if (/^i look\b/i.test(t)) return true;
    if (/\bi look around\b/i.test(t)) return true;
    if (/^survey\b/i.test(t)) return true;
    if (/^scan the\b/i.test(t)) return true;
    if (/\bscan the (area|room|cavern|tunnels?)\b/i.test(t)) return true;
    return false;
}

/**
 * @param {import('mysql2/promise').Pool} db
 * @param {object} player
 * @param {string} action
 * @returns {Promise<string>} Extra [SYSTEM] lines for engineNotice (empty if not a search action).
 */
async function enrichSearchExploration(db, player, action) {
    if (!isSearchLikeAction(action)) return '';

    const locId = String(player.current_location || '').trim();
    if (!locId) return '';

    let hiddenLore = null;
    let descriptionSeed = null;

    try {
        const [locRows] = await db.execute(
            'SELECT description_seed, hidden_lore FROM location_seeds WHERE location_id = ? LIMIT 1',
            [locId]
        );
        if (locRows.length) {
            descriptionSeed = locRows[0].description_seed;
            hiddenLore = locRows[0].hidden_lore;
        }
    } catch (err) {
        const noColumn =
            err.code === 'ER_BAD_FIELD_ERROR' ||
            err.errno === 1054 ||
            String(err.sqlMessage || '').includes('hidden_lore');
        if (noColumn) {
            const [locRows] = await db.execute(
                'SELECT description_seed FROM location_seeds WHERE location_id = ? LIMIT 1',
                [locId]
            );
            if (locRows.length) descriptionSeed = locRows[0].description_seed;
        } else {
            throw err;
        }
    }

    const [npcRows] = await db.execute(
        `SELECT original_name, new_name, current_species, status_log
         FROM reincarnated_npcs
         WHERE current_location = ?
         ORDER BY npc_id ASC`,
        [locId]
    );

    const parts = [];

    if (hiddenLore && String(hiddenLore).trim()) {
        parts.push(`[DISCOVERY] ${String(hiddenLore).trim()}`);
    }

    if (npcRows.length) {
        for (const n of npcRows) {
            const label = n.new_name || n.original_name || 'Unknown';
            const spec = n.current_species || 'Unknown form';
            const log = n.status_log ? String(n.status_log).trim() : 'A familiar presence stirs in this stratum.';
            parts.push(`[FIGURE NEARBY] ${label} (${spec}): ${log}`);
        }
    }

    if (!parts.length) {
        const seedHint = descriptionSeed
            ? ` You note details from the terrain: ${String(descriptionSeed).slice(0, 200)}…`
            : '';
        parts.push(`[SEARCH] The area offers hazards and scraps, but nothing extraordinary stands out yet.${seedHint}`);
    }

    return ` ${parts.join(' ')}`.trim();
}

module.exports = {
    isSearchLikeAction,
    enrichSearchExploration
};
