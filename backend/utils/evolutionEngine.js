/**
 * Evolution paths from `evolution_paths`: species metamorphosis when level thresholds are met.
 */

const SPECIES_STAT_BONUS = 10;

/**
 * @param {import('mysql2/promise').Pool} db
 * @param {object} player Row from `current_life` (+ joined fields ok)
 * @returns {Promise<Array<{ evolution_id: number, from_species: string, to_species: string, req_level: number, description: string|null }>>}
 */
async function checkEvolutionEligibility(db, player) {
    const species = String(player.species || '').trim();
    if (!species) return [];

    const level = Math.floor(Number(player.current_level) || 1);

    const [rows] = await db.execute(
        `SELECT evolution_id, from_species, to_species, req_level, description
         FROM evolution_paths
         WHERE from_species = ? AND req_level <= ?`,
        [species, level]
    );

    return rows.map((r) => ({
        evolution_id: r.evolution_id,
        from_species: r.from_species,
        to_species: r.to_species,
        req_level: Math.floor(Number(r.req_level) || 0),
        description: r.description
    }));
}

/**
 * Apply evolution: new species, +SPECIES_STAT_BONUS to all core stats,
 * max_hp and max_sp ×1.5 (floor), hp and sp set to new caps.
 *
 * @param {import('mysql2/promise').Pool} db
 * @param {object} player
 * @param {string} toSpecies Must match `evolution_paths.to_species` for current `from_species` and level.
 * @returns {Promise<object>} Updated player object (mutated in place + returned)
 */
async function evolvePlayer(db, player, toSpecies) {
    const target = String(toSpecies || '').trim();
    if (!target) {
        const err = new Error('Evolution target species is required.');
        err.code = 'INVALID_EVOLUTION';
        throw err;
    }

    const from = String(player.species || '').trim();
    const level = Math.floor(Number(player.current_level) || 1);

    const [paths] = await db.execute(
        `SELECT evolution_id, to_species, description
         FROM evolution_paths
         WHERE from_species = ? AND to_species = ? AND req_level <= ?`,
        [from, target, level]
    );

    if (!paths.length) {
        const err = new Error('No valid evolution path for this vessel and level.');
        err.code = 'INVALID_EVOLUTION';
        throw err;
    }

    const bonus = SPECIES_STAT_BONUS;
    const offense = Math.floor(Number(player.offense) || 0) + bonus;
    const defense = Math.floor(Number(player.defense) || 0) + bonus;
    const magic_power = Math.floor(Number(player.magic_power) || 0) + bonus;
    const resistance = Math.floor(Number(player.resistance) || 0) + bonus;
    const speed = Math.floor(Number(player.speed) || 0) + bonus;

    const maxHp = Math.max(1, Math.floor(Number(player.max_hp) * 1.5));
    const maxSp = Math.max(1, Math.floor(Number(player.max_sp) * 1.5));
    const hp = maxHp;
    const sp = maxSp;

    const maxMp = Math.max(0, Math.floor(Number(player.max_mp) || 0));
    let mp = Math.floor(Number(player.mp) ?? maxMp);
    if (mp > maxMp) mp = maxMp;

    await db.execute(
        `UPDATE current_life SET
            species = ?,
            offense = ?, defense = ?, magic_power = ?, resistance = ?, speed = ?,
            max_hp = ?, hp = ?,
            max_sp = ?, sp = ?,
            mp = ?
         WHERE life_id = ? AND user_id = ?`,
        [
            target,
            offense,
            defense,
            magic_power,
            resistance,
            speed,
            maxHp,
            hp,
            maxSp,
            sp,
            mp,
            player.life_id,
            player.user_id
        ]
    );

    player.species = target;
    player.offense = offense;
    player.defense = defense;
    player.magic_power = magic_power;
    player.resistance = resistance;
    player.speed = speed;
    player.max_hp = maxHp;
    player.hp = hp;
    player.max_sp = maxSp;
    player.sp = sp;
    player.mp = mp;
    player.max_mp = maxMp;

    return player;
}

module.exports = {
    checkEvolutionEligibility,
    evolvePlayer,
    SPECIES_STAT_BONUS
};
