/**
 * survivalEngine.js — SP / hunger with combat override + rest recovery
 */

const DEFAULT_MAX_SP = 100;

function normalizeNumber(value, fallback = 0) {
    const n = Number(value);
    return Number.isFinite(n) ? n : fallback;
}

function clampSp(player, sp) {
    const maxSp = normalizeNumber(player.max_sp, DEFAULT_MAX_SP);
    let s = normalizeNumber(sp, maxSp);
    if (!Number.isFinite(s)) s = 0;
    return Math.max(0, Math.min(maxSp, Math.floor(s)));
}

function clampHunger(h) {
    let x = normalizeNumber(h, 50);
    if (!Number.isFinite(x)) x = 50;
    return Math.max(0, Math.min(100, Math.floor(x)));
}

/** Same semantics as combatEncounterEngine aggressive triggers (keep in sync). */
const AGGRESSIVE_TRIGGERS = [
    'attack', 'skill', 'strike', 'grapple', 'charge', 'slash', 'hit', 'kill',
    'risky action', 'beast'
];

function isAggressiveAction(action) {
    const a = String(action || '').toLowerCase();
    return AGGRESSIVE_TRIGGERS.some((word) => a.includes(word));
}

const REST_TRIGGERS = [
    'rest', 'sleep', 'nap', 'wait', 'pause', 'catch breath', 'catching breath',
    'catch my breath', 'breather', 'take a breather', 'sit down', 'sit and',
    'recuperate', 'recover', 'recover stamina', 'catch your breath', 'lie down',
    'camp', 'make camp'
];

function isRestAction(action) {
    const a = String(action || '').toLowerCase();
    return REST_TRIGGERS.some((phrase) => a.includes(phrase));
}

/**
 * @param {object} player
 * @param {string} action
 * @param {{ aggressiveCombatStamina?: boolean }} [options]
 *   If true, combatEncounterEngine will apply attack/skill SP — survival does not tax SP for this turn.
 */
const calculateSurvivalCost = (player, action, options = {}) => {
    const aggressiveCombatStamina = !!options.aggressiveCombatStamina;

    let hungerDelta = 2; // positive = drain hunger
    let spDelta = 5;     // positive = drain SP

    const normalizedAction = String(action || '').toLowerCase();

    // --- REST: restore SP, slight hunger cost ---
    if (isRestAction(action)) {
        hungerDelta = 3;
        spDelta = -20; // restore 20 SP
    }
    // --- TRAVEL (heavy) ---
    else if (normalizedAction.includes('travel') || normalizedAction.includes('move to')) {
        hungerDelta = 15;
        const spdModifier = Math.max(1, 20 / Math.max(1, normalizeNumber(player.speed, 1)));
        spDelta = Math.min(40, 20 * spdModifier);
    }
    // --- EAT (not rest) ---
    else if (normalizedAction.includes('eat')) {
        hungerDelta = -40;
        spDelta = 5;
    }
    // --- AGGRESSION: combat layer owns SP for attacks/skills ---
    else if (aggressiveCombatStamina || normalizedAction.includes('attack')) {
        hungerDelta = 8;
        spDelta = 0;
    }

    // --- VESSEL MODIFIERS (hunger only) ---
    if (player.vessel_type === 'Predator') hungerDelta *= 1.3;
    if (player.vessel_type === 'Scavenger') hungerDelta *= 0.8;

    hungerDelta = Math.round(hungerDelta);

    const startHunger = clampHunger(player.hunger);
    const startSp = clampSp(player, player.sp);

    const newHunger = clampHunger(startHunger - hungerDelta);
    const newSP = clampSp(player, startSp - spDelta);

    let statusNotice = '';
    let healthPenalty = 0;

    if (newHunger <= 0) {
        statusNotice += '[SYSTEM: STARVATION DETECTED. HP REDUCED.] ';
        healthPenalty = 5;
    }
    if (newSP <= 0 && spDelta > 0) {
        statusNotice += '[SYSTEM: EXHAUSTION DETECTED. ACTION EFFICIENCY DROPPED.] ';
    }
    if (isRestAction(action) && spDelta < 0) {
        statusNotice += '[SYSTEM: STAMINA RECOVERY. Breathing stabilized.] ';
    }

    return {
        hunger: newHunger,
        sp: newSP,
        healthPenalty,
        statusNotice
    };
};

module.exports = {
    calculateSurvivalCost,
    isAggressiveAction,
    isRestAction,
    clampSp,
    clampHunger
};
