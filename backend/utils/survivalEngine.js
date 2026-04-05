/**
 * survivalEngine.js
 * Calculates metabolic costs and status effects based on player actions.
 */

const calculateSurvivalCost = (player, action) => {
    let hungerCost = 2; // Base movement cost
    let spCost = 5;     // Base movement cost

    const normalizedAction = action.toLowerCase();

    // Context-specific costs
    if (normalizedAction.includes('attack')) {
        hungerCost = 8;
        spCost = 15;
    } else if (normalizedAction.includes('rest')) {
        hungerCost = 1;
        spCost = -25; // Restores SP
    } else if (normalizedAction.includes('eat')) {
        hungerCost = -30; // Restores Hunger
        spCost = 5;
    }

    // Path-based modifiers (Predators burn fuel faster, etc.)
    if (player.vessel_type === 'Predator') hungerCost *= 1.5;
    if (player.vessel_type === 'Prey') spCost *= 0.8;

    // Apply changes
    const newHunger = Math.max(0, Math.min(100, player.hunger - hungerCost));
    const newSP = Math.max(0, Math.min(player.max_sp, player.sp - spCost));

    // Determine status effects
    let statusNotice = "";
    let healthPenalty = 0;

    if (newHunger <= 0) {
        statusNotice += "[SYSTEM: STARVATION DETECTED. HP REDUCED.] ";
        healthPenalty = 5;
    }

    if (newSP <= 0) {
        statusNotice += "[SYSTEM: EXHAUSTION DETECTED. SPEED DEBUFF.] ";
    }

    return {
        hunger: newHunger,
        sp: newSP,
        healthPenalty,
        statusNotice
    };
};

module.exports = { calculateSurvivalCost };