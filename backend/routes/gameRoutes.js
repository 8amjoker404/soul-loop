// backend/routes/gameRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');
const { handleAdminCheat } = require('../utils/cheatEngine');
const { scanWorldContext } = require('../utils/worldEngine');
const { processLevelUp } = require('../utils/gameEngine');
const { resolveCombatEncounter } = require('../utils/combatEncounterEngine');
const { performIsekaiBirth } = require('../utils/reincarnationEngine');
const { calculateSurvivalCost } = require('../utils/survivalEngine');

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// ROUTE 1: //api/game/status - Fetch current player state, recent history, and available choices
// ==========================================
router.get('/status', async (req, res) => {
    const userId = req.user.userId;

    try {
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, u.system_voice, s.permanent_skills 
            FROM current_life c 
            JOIN users u ON c.user_id = u.id 
            JOIN soul_library s ON c.user_id = s.user_id 
            WHERE c.user_id = ? AND c.is_alive = 1`, 
            [userId]
        );
        
        if (!playerRows.length) return res.status(404).json({ error: "No active life found." });
        const player = playerRows[0];

        const [logRows] = await db.execute(`
            SELECT user_action, system_response, choices, bg_image, encounter_image 
            FROM action_logs 
            WHERE life_id = ? ORDER BY created_at DESC LIMIT 5`,
            [player.life_id]
        );

        const history = logRows.reverse();
        const lastLog = history[history.length - 1];

        res.json({
            player_state: player,
            recent_history: history.map(h => ({
                user_action: h.user_action,
                system_response: h.system_response
            })),
            choices: lastLog ? JSON.parse(lastLog.choices) : [],
            visuals: {
                background: lastLog ? lastLog.bg_image : null,
                entity: lastLog ? lastLog.encounter_image : null
            }
        });

    } catch (err) {
        console.error("STATUS_ERROR:", err);
        res.status(500).json({ error: "Server malfunction." });
    }
});
// ==========================================
// ROUTE: //api/game/reincarnate - Handles the entire reincarnation process based on AI judgment of the soul scan answers
// ==========================================
router.get('/reincarnate/questions', async (req, res) => {
    try {
        const prompt = `
            [SYSTEM: INITIATING SOUL SCAN]
            Role: 'Voice of the World' (Cold, mechanical, objective).
            Task: Generate 3 deep psychological questions to judge a human soul before reincarnation.
            Each question must have exactly 3 options that lean toward:
            1. Predator (Aggression/Power)
            2. Prey (Caution/Protection)
            3. Scavenger (Survival/Resourcefulness)
            
            Format the response as a JSON array of objects:
            [
              { "id": 1, "text": "...", "options": ["...", "...", "..."] }
            ]
            Only return the JSON.
        `;

        const result = await model.generateContent(prompt);
        const aiResponse = result.response.text();
        
        // Parsing the AI's JSON output
        const questions = JSON.parse(aiResponse.replace(/```json|```/g, '').trim());

        res.json({
            system_log: "[SCANNING NEURAL FRAGMENTS... SENSORS ACTIVE]",
            questions: questions
        });

    } catch (err) {
        console.error("AI_QUESTION_ERROR:", err);
        res.status(500).json({ error: "The Void is too unstable to scan your soul." });
    }
});

// ==========================================
// ROUTE: //api/game/reincarnate - Handles the entire reincarnation process based on AI judgment of the soul scan answers
// ==========================================
router.post('/reincarnate', async (req, res) => {
    const userId = req.user?.userId;
    const { answers } = req.body;

    try {
        if (!userId || !answers || !Array.isArray(answers)) {
            return res.status(400).json({ error: "Soul records incomplete. Neural sync failed." });
        }

        const blueprintPrompt = `
            [SYSTEM ANALYSIS: SOUL SCAN RESULTS]
            The subject has provided the following responses to the psychological scan:
            ${JSON.stringify(answers)}

            TASK:
            1. Analyze the 'weight' and 'intent' of these responses.
            2. Determine if the soul leans toward Predator, Prey, or Scavenger.
            3. Construct a high-tier reincarnation blueprint based on these answers.
            
            Return ONLY a JSON object:
            {
              "path": "Predator | Prey | Scavenger",
              "species": "Unique Species Name",
              "location": "elroe_upper | royal_capital | magma_layer | water_stratum | elroe_lower",
              "hp": 120, "mp": 60, "offense": 25, "defense": 25, "speed": 25, "sp": 60
            }
        `;

        const bpResult = await model.generateContent(blueprintPrompt);
        const blueprint = JSON.parse(bpResult.response.text().trim().replace(/```json|```/g, ''));

        const vessel = await performIsekaiBirth(userId, blueprint.path, blueprint);

        await db.execute('UPDATE current_life SET is_alive = 0 WHERE user_id = ?', [userId]);

        const [insertResult] = await db.execute(
            `INSERT INTO current_life (
                user_id, species, vessel_type, current_location, 
                hp, max_hp, mp, max_mp, hunger, sp, max_sp, 
                offense, defense, speed, is_alive
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1)`,
            [
                userId, 
                vessel.species, 
                blueprint.path, 
                vessel.starting_location,
                vessel.base_hp, vessel.base_hp, 
                vessel.base_mp, vessel.base_mp, 
                100,
                vessel.base_sp, vessel.base_sp,
                vessel.base_offense, 
                vessel.base_defense, 
                vessel.base_speed
            ]
        );

        const newLifeId = insertResult.insertId;

        const [userRows] = await db.execute(
            'SELECT system_voice FROM users WHERE id = ?',
            [userId]
        );
        const systemVoice = userRows[0]?.system_voice || 'ADMIN';

        const aiPrompt = buildSystemPrompt(
            { 
                ...vessel, 
                hp: vessel.base_hp, 
                max_hp: vessel.base_hp, 
                hunger: 100, 
                sp: vessel.base_sp, 
                current_level: 1, 
                vessel_type: blueprint.path,
                system_voice: systemVoice
            },
            { description_seed: vessel.starting_location },
            `Soul Scan Completed. Identity Confirmed.`,
            `The Voice of the World has processed your essence as ${blueprint.path}. Awakening as ${vessel.species} in ${vessel.starting_location}.`
        );

        const narrationResult = await model.generateContent(aiPrompt);
        const aiResponse = narrationResult.response.text();
        
        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        const choices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)].map(m => m[1]);

        await db.execute(
            `INSERT INTO action_logs (life_id, user_action, system_response, choices) VALUES (?, ?, ?, ?)`,
            [newLifeId, 'System Judgment Awakening', cleanStory, JSON.stringify(choices)]
        );

        res.json({
            status: "AWAKENED",
            judgment: {
                path: blueprint.path,
                location: vessel.starting_location,
                species: vessel.species
            },
            narration: cleanStory,
            choices: choices,
            stats: {
                hp: vessel.base_hp,
                offense: vessel.base_offense,
                hunger: 100,
                sp: vessel.base_sp
            }
        });

    } catch (err) {
        console.error("REINCARNATION_CRITICAL_FAILURE:", err);
        res.status(500).json({ error: "The System failed to finalize your soul judgment." });
    }
});

// ==========================================
// THE MASTER ACTION // api/game/action
// ==========================================
router.post('/action', async (req, res) => {
    const userId = req.user?.userId;
    const { action } = req.body || {};

    try {
        if (!userId) {
            return res.status(401).json({ error: "Unauthorized." });
        }

        const normalizedAction = String(action || '').trim();

        if (!normalizedAction) {
            return res.status(400).json({ error: "action is required." });
        }

        // --- 1. FETCH PLAYER STATE ---
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, u.system_voice, s.permanent_skills 
            FROM current_life c 
            JOIN users u ON c.user_id = u.id 
            JOIN soul_library s ON c.user_id = s.user_id 
            WHERE c.user_id = ? AND c.is_alive = 1
        `, [userId]);

        if (!playerRows.length) {
            return res.status(404).json({ error: "No active life found." });
        }

        let player = playerRows[0];

        // --- 2. SURVIVAL CALCULATIONS ---
        const survival = calculateSurvivalCost(player, normalizedAction);
        player.hunger = survival.hunger;
        player.sp = survival.sp;
        player.hp -= survival.healthPenalty; 

        // --- 3. CHEAT ENGINE CHECK ---
        const cheatCheck = await handleAdminCheat(normalizedAction, player, userId);
        if (cheatCheck.isCheat) {
            return res.json(cheatCheck.response);
        }

        // --- 4. WORLD ENGINE SCAN (Filtering out Player Context) ---
        const worldData = await scanWorldContext(player, userId);

        // --- 5. COMBAT ENGINE LOGIC (Persistent Encounters) ---
        let engineNotice = survival.statusNotice || "";
        let monsterContext = "";
        let monsterButtons = [];
        let monsterImageUrl = null;

        const combatData = await resolveCombatEncounter({
            player,
            action: normalizedAction,
            engineNotice
        });

        player = combatData.player;
        engineNotice = combatData.engineNotice;
        monsterContext = combatData.monsterContext;
        monsterButtons = combatData.monsterButtons;
        monsterImageUrl = combatData.monsterImageUrl;

        // --- 6. LEVEL ENGINE ---
        const levelData = processLevelUp(player);
        if (levelData.leveledUp) {
            Object.assign(player, levelData);
            engineNotice += ` ${levelData.systemLog}`;
        }

        // --- 7. VISUALS & AI NARRATION ---
        const [locRows] = await db.execute(
            'SELECT location_image FROM location_seeds WHERE location_id = ?',
            [player.current_location]
        );

        const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;
        
        // REMOVED worldData.pvpContext to ensure other players are not mentioned
        const fullContext = `${monsterContext}${worldData.worldLore || ""}${engineNotice}`;

        const aiPrompt = buildSystemPrompt(
            player, 
            { description_seed: player.current_location },
            normalizedAction,
            fullContext
        );

        const aiResult = await model.generateContent(aiPrompt);
        const aiResponse = aiResult?.response?.text?.() || "";

        // --- 8. PARSING & DB FINALIZATION ---
        let finalHp = Math.max(0, Number(player.hp || 0));
        let isAlive = true;

        const hpM = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
        if (hpM) finalHp = parseInt(hpM[1], 10);

        if (finalHp <= 0 || aiResponse.includes("[STATUS: DECEASED]")) {
            isAlive = false;
            finalHp = 0;
        }

        // Parse AI Choices
        const aiChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
            .map(m => m[1]).filter(Boolean).map(choice => String(choice).trim());

        // REMOVED worldData.pvpButtons to prevent "Challenge Player" options
        const allChoices = [...monsterButtons, ...aiChoices]
            .filter(Boolean).map(choice => String(choice).trim());

        const uniqueChoices = [...new Set(allChoices)];
        for (let i = uniqueChoices.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [uniqueChoices[i], uniqueChoices[j]] = [uniqueChoices[j], uniqueChoices[i]];
        }

        const finalChoices = uniqueChoices.slice(0, 4);

        // --- 9. SAVE UPDATED STATS ---
        const updateLifeParams = [
            finalHp,
            Number(player.xp || 0),
            Number(player.current_level || 1),
            Number(player.max_hp || finalHp),
            Number(player.next_level_xp || 100),
            Number(player.offense || 1),
            Number(player.defense || 1),
            Number(player.hunger),
            Number(player.sp),
            isAlive ? 1 : 0,
            player.life_id
        ];

        await db.execute(
            `UPDATE current_life 
             SET hp = ?, xp = ?, current_level = ?, max_hp = ?, next_level_xp = ?, 
                 offense = ?, defense = ?, hunger = ?, sp = ?, is_alive = ? 
             WHERE life_id = ?`,
            updateLifeParams
        );

        // --- 10. LOGGING AND RESPONSE ---
        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        const logParams = [player.life_id, normalizedAction, cleanStory, JSON.stringify(finalChoices), backgroundUrl, monsterImageUrl];

        await db.execute(
            `INSERT INTO action_logs (life_id, user_action, system_response, choices, bg_image, encounter_image) 
             VALUES (?, ?, ?, ?, ?, ?)`,
            logParams
        );

        res.json({
            status: isAlive ? "ALIVE" : "DEAD",
            stats: {
                hp: finalHp,
                max_hp: player.max_hp,
                hunger: player.hunger,
                sp: player.sp,
                level: player.current_level,
                xp: player.xp,
                next_mark: player.next_level_xp
            },
            system_output: cleanStory,
            choices: finalChoices,
            visuals: { background: backgroundUrl, entity: monsterImageUrl }
        });

    } catch (err) {
        console.error("MASTER_ACTION_ERROR:", err);
        return res.status(500).json({ error: "System Error.", details: err.message });
    }
});


module.exports = router;