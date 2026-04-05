/**
 * gameEngine.js
 * Integrated with Survival Vitals (Hunger/SP)
 */

const calculateCombat = (player, monster) => {
    // 1. Apply Starvation Debuff (50% power if starving)
    const hungerFactor = (player.hunger <= 0) ? 0.5 : 1.0;
    
    // 2. Base RPG Math
    const rawDamage = ((player.offense * player.current_level) - (monster.base_defense / 2)) * hungerFactor;
    const damageDealt = Math.max(1, Math.floor(rawDamage));
    
    // 3. Check Monster Status
    const isMonsterDead = (monster.base_hp - damageDealt) <= 0;
    
    // 4. Survival Costs (Combat is exhausting)
    const combatSpCost = 15;
    const combatHungerCost = 8;

    // 5. XP Reward based on Danger Rank
    const rankXP = { 'F': 20, 'E': 50, 'D': 100, 'C': 250, 'B': 500, 'A': 1000, 'S': 5000 };
    const xpGained = isMonsterDead ? (rankXP[monster.danger_rank] || 20) : 5;

    return { 
        damageDealt, 
        isMonsterDead, 
        xpGained, 
        spCost: combatSpCost, 
        hungerCost: combatHungerCost,
        monsterRemainingHp: Math.max(0, monster.base_hp - damageDealt)
    };
};

const processLevelUp = (player) => {
    if (player.xp >= player.next_level_xp) {
        const newLevel = player.current_level + 1;
        const hpGain = 15;
        const mpGain = 10;
        const statGain = 3;

        return {
            leveledUp: true,
            current_level: newLevel,
            max_hp: player.max_hp + hpGain,
            hp: player.max_hp + hpGain, // Full heal on level up
            max_mp: player.max_mp + mpGain,
            offense: player.offense + statGain,
            defense: player.defense + statGain,
            speed: player.speed + statGain,
            next_level_xp: Math.floor(player.next_level_xp * 2.5),
            systemLog: `[SYSTEM_EVOLUTION]: Leveled to ${newLevel}. Strength grows.`
        };
    }
    return { leveledUp: false };
};

module.exports = { calculateCombat, processLevelUp };