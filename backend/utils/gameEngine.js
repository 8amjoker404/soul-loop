// utils/gameEngine.js

const calculateCombat = (player, monster) => {
    // Basic RPG Math: (Atk * Level) - (Def / 2)
    const rawDamage = (player.offense * player.current_level) - (monster.defense / 2);
    const damageDealt = Math.max(1, Math.floor(rawDamage));
    
    // Check if player kills the monster
    const isMonsterDead = (monster.hp - damageDealt) <= 0;
    
    // XP Reward based on Danger Rank
    const rankXP = { 'F': 10, 'E': 25, 'D': 50, 'C': 100, 'B': 250, 'A': 500, 'S': 1000 };
    const xpGained = isMonsterDead ? (rankXP[monster.danger_rank] || 10) : 5;

    return { damageDealt, isMonsterDead, xpGained };
};

const processLevelUp = (player) => {
    let { current_level, max_hp, max_mp, offense, defense, speed, next_level_xp } = player;
    
    let leveledUp = false;
    let log = "";

    if (player.xp >= next_level_xp) {
        leveledUp = true;
        current_level += 1;
        
        // Scale next "Mark" (100 -> 250 -> 562 -> 1265)
        const newNextXp = Math.floor(next_level_xp * 2.5);
        
        // Stat Growth
        const hpGain = 10;
        const mpGain = 5;
        const statGain = 2;

        log = `[LEVEL UP]: Reached Level ${current_level}. HP+${hpGain}, MP+${mpGain}, Stats increased.`;
        
        return {
            current_level,
            max_hp: max_hp + hpGain,
            max_mp: max_mp + mpGain,
            offense: offense + statGain,
            defense: defense + statGain,
            speed: speed + statGain,
            next_level_xp: newNextXp,
            leveledUp,
            log
        };
    }
    return { leveledUp: false };
};

module.exports = { calculateCombat, processLevelUp };