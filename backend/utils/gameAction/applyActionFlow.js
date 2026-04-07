// backend/utils/gameAction/applyActionFlow.js
const { handleAdminCheat } = require('../cheatEngine');
const { scanWorldContext } = require('../worldEngine');
const { checkLevelUp } = require('../gameEngine');
const { resolveCombatEncounter } = require('../combatEncounterEngine');
const { calculateSurvivalCost, isAggressiveAction } = require('../survivalEngine');
const { parseSurvivalAction } = require('../actionParser');
const { handleZoneTravel } = require('../travelEngine');
const { handleScavengeAction } = require('./scavengeEngine');

async function applyActionFlow({ player, userId, action, db }) {
    // --- 1. SCAVENGE / CONSUME / HARVEST (bypasses standard survival cost for this turn) ---
    const scavengeResult = handleScavengeAction(player, action);
    const scavengeHandled = scavengeResult != null;

    let survival;
    if (scavengeHandled) {
        player = scavengeResult.player;
        survival = {
            hunger: player.hunger,
            sp: player.sp,
            healthPenalty: 0,
            statusNotice: ''
        };
    } else {
        survival = calculateSurvivalCost(player, action, {
            aggressiveCombatStamina: isAggressiveAction(action)
        });
        player.hunger = survival.hunger;
        player.sp = survival.sp;
        player.hp -= survival.healthPenalty;
    }

    // --- 2. CHEAT ENGINE CHECK ---
    const cheatCheck = await handleAdminCheat(action, player, userId);
    if (cheatCheck.isCheat) {
        const error = new Error("CHEAT_RESPONSE");
        error.cheatResponse = cheatCheck.response;
        throw error;
    }

    // --- 3. WORLD ENGINE SCAN ---
    const worldData = await scanWorldContext(player, userId);

    // --- 4. COMBAT ENGINE LOGIC ---
    let engineNotice = scavengeHandled
        ? (scavengeResult.engineNotice || '')
        : (survival.statusNotice || '');
    let monsterContext = "";
    let monsterButtons = [];
    let monsterImageUrl = null;

    const combatData = await resolveCombatEncounter({
        player,
        action,
        engineNotice
    });

    player = combatData.player;
    engineNotice = combatData.engineNotice;
    monsterContext = combatData.monsterContext;
    monsterButtons = combatData.monsterButtons;
    monsterImageUrl = combatData.monsterImageUrl;

    // --- 5. SURVIVAL ACTION PARSER (skip if scavenge engine already resolved consume/harvest) ---
    if (
        !scavengeHandled &&
        !action.startsWith('Attack') &&
        !action.startsWith('Attempt to Flee')
    ) {
        const parsedSurvival = parseSurvivalAction(player, action, engineNotice);
        player = parsedSurvival.player;
        engineNotice = parsedSurvival.engineNotice;
    }

    // --- 6. ZONE TRAVEL PARSER ---
    const travelData = await handleZoneTravel(action, player, db);
    if (travelData.newLocation !== player.current_location) {
        player.current_location = travelData.newLocation;
    }
    engineNotice += travelData.travelNotice;

    // --- 7. LEVEL UP (XP threshold vs next_level_xp; persists to DB) ---
    const { levelUpNotice } = await checkLevelUp(player, db);
    if (levelUpNotice) {
        engineNotice += ` ${levelUpNotice}`;
    }

    return {
        player,
        engineNotice,
        levelUpNotice: levelUpNotice || '',
        monsterContext,
        monsterButtons,
        monsterImageUrl,
        worldLore: worldData.worldLore || "",
        activeMonster: combatData.activeMonster // <--- THE FIX: Passing the monster data down the chain!
    };
}

module.exports = { applyActionFlow };