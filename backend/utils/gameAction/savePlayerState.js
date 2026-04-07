// backend/utils/gameAction/savePlayerState.js
const { clampSp, clampHunger } = require('../survivalEngine');

async function saveUpdatedPlayerState({ db, player, finalHp, isAlive }) {
    const safeSp = clampSp(player, player.sp);
    const safeHunger = clampHunger(player.hunger);

    const updateLifeParams = [
        finalHp,
        Number(player.xp || 0),
        Number(player.current_level || 1),
        Number(player.max_hp || finalHp),
        Number(player.max_mp ?? 0),
        Number(player.max_sp ?? 0),
        Number(player.next_level_xp || 100),
        Number(player.offense || 1),
        Number(player.defense || 1),
        Number(player.magic_power ?? 0),
        Number(player.resistance ?? 0),
        Number(player.speed ?? 0),
        safeHunger,
        safeSp,
        Number(player.mp ?? player.max_mp ?? 0),
        Number(player.attribute_points || 0),
        Number(player.skill_points || 0),
        String(player.species || ''),
        player.current_location,
        isAlive ? 1 : 0,
        player.inventory,
        player.home_base,
        player.life_id
    ];

    await db.execute(
        `UPDATE current_life
         SET hp = ?, xp = ?, current_level = ?, max_hp = ?, max_mp = ?, max_sp = ?, next_level_xp = ?,
             offense = ?, defense = ?, magic_power = ?, resistance = ?, speed = ?,
             hunger = ?, sp = ?,
             mp = ?, attribute_points = ?, skill_points = ?,
             species = ?,
             current_location = ?, is_alive = ?,
             inventory = ?, home_base = ?
         WHERE life_id = ?`,
        updateLifeParams
    );
}

module.exports = { saveUpdatedPlayerState };