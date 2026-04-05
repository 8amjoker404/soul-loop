const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');
const { handleAdminCheat } = require('../utils/cheatEngine');
const { scanWorldContext } = require('../utils/worldEngine');
const { calculateCombat, processLevelUp } = require('../utils/gameEngine');
const { performIsekaiBirth } = require('../utils/reincarnationEngine');
const { calculateSurvivalCost } = require('../utils/survivalEngine');

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// ROUTE 1: GET CURRENT STATUS (CLEAN VERSION)
// ==========================================
router.get('/status', async (req, res) => {
    const userId = req.user.userId;

    try {
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, s.permanent_skills 
            FROM current_life c 
            JOIN users u ON c.user_id = u.id 
            JOIN soul_library s ON c.user_id = s.user_id 
            WHERE c.user_id = ? AND c.is_alive = 1`, 
            [userId]
        );
        
        if (!playerRows.length) return res.status(404).json({ error: "No active life found." });
        const player = playerRows[0];

        // Fetch logs with Visuals
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
// ROUTE: GET AI-GENERATED SOUL SCAN
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
// ROUTE: THE SYSTEM JUDGMENT & BIRTH
// ==========================================
router.post('/reincarnate', async (req, res) => {
    const userId = req.user?.userId;
    // We now focus purely on the results of the Soul Scan questions
    const { answers } = req.body;

    try {
        if (!userId || !answers || !Array.isArray(answers)) {
            return res.status(400).json({ error: "Soul records incomplete. Neural sync failed." });
        }

        // 1. AI BLUEPRINT GENERATION
        // The AI analyzes the 3 answers to determine Path, Species, Location, and Stats
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

        // 2. TRIGGER DYNAMIC BIRTH UTILITY
        // Passes the AI's determined blueprint into the engine
        const vessel = await performIsekaiBirth(userId, blueprint.path, blueprint);

        // 3. DATABASE: RESET PREVIOUS STATE
        await db.execute('UPDATE current_life SET is_alive = 0 WHERE user_id = ?', [userId]);

        // 4. DATABASE: BIRTH NEW VESSEL
        // Uses the AI-defined stats from the blueprint
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
                100, // Hunger starts full
                vessel.base_sp, vessel.base_sp, // Stamina
                vessel.base_offense, 
                vessel.base_defense, 
                vessel.base_speed
            ]
        );

        const newLifeId = insertResult.insertId;

        // 5. NARRATIVE AWAKENING
        // Uses buildSystemPrompt to describe the transition based on the quiz answers
        const aiPrompt = buildSystemPrompt(
            { 
                ...vessel, 
                hp: vessel.base_hp, 
                max_hp: vessel.base_hp, 
                hunger: 100, 
                sp: vessel.base_sp, 
                current_level: 1, 
                vessel_type: blueprint.path 
            },
            { description_seed: vessel.starting_location },
            `Soul Scan Completed. Identity Confirmed.`,
            `The Voice of the World has processed your essence as ${blueprint.path}. Awakening as ${vessel.species} in ${vessel.starting_location}.`
        );

        const narrationResult = await model.generateContent(aiPrompt);
        const aiResponse = narrationResult.response.text();
        
        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();
        const choices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)].map(m => m[1]);

        // 6. SAVE LOG & RESPOND
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
        // Includes Hunger, SP, and Vessel_Type from the updated SQL schema
        const [playerRows] = await db.execute(`
            SELECT c.*, u.username, s.permanent_skills 
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
        // This calculates the metabolic cost of the action before combat/world logic
        const survival = calculateSurvivalCost(player, normalizedAction);
        player.hunger = survival.hunger;
        player.sp = survival.sp;
        player.hp -= survival.healthPenalty; // Apply starvation damage if applicable

        // --- 3. CHEAT ENGINE CHECK ---
        const cheatCheck = await handleAdminCheat(normalizedAction, player, userId);
        if (cheatCheck.isCheat) {
            return res.json(cheatCheck.response);
        }

        // --- 4. WORLD ENGINE SCAN ---
        const worldData = await scanWorldContext(player, userId);

        // --- 5. COMBAT ENGINE LOGIC ---
        let engineNotice = survival.statusNotice || ""; // Start notice with survival alerts
        let monsterContext = "";
        let monsterButtons = [];
        let monsterImageUrl = null;

        const [spawns] = await db.execute(`
            SELECT m.* FROM zone_spawns z 
            JOIN master_npcs m ON z.npc_id = m.id 
            WHERE z.zone_name = ? AND RAND() * 100 <= z.spawn_chance 
            LIMIT 1
        `, [player.current_location]);

        if (spawns.length > 0) {
            const m = spawns[0];
            monsterImageUrl = m.npc_image || null;

            if (normalizedAction.startsWith("Attack the")) {
                const result = calculateCombat(player, m);
                player.xp += Number(result.xpGained || 0);

                engineNotice += ` [ENGINE_COMBAT]: Dealt ${result.damageDealt} DMG. ${
                    result.isMonsterDead ? 'Slain.' : 'Survived.'
                } Gained ${result.xpGained} XP.`;
            } else {
                monsterContext = `[ENCOUNTER: WILD ${m.name} (${m.danger_rank})]. ${m.description}. `;
                monsterButtons.push(`Attack the ${m.name}`);
            }
        }

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
        const fullContext = `${worldData.pvpContext || ""}${monsterContext}${worldData.worldLore || ""}${engineNotice}`;

        const aiPrompt = buildSystemPrompt(
            player, // AI now has access to player.hunger and player.sp
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

        // Parse Choices
        const aiChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
            .map(m => m[1]).filter(Boolean).map(choice => String(choice).trim());

        const allChoices = [...(worldData?.pvpButtons || []), ...monsterButtons, ...aiChoices]
            .filter(Boolean).map(choice => String(choice).trim());

        const uniqueChoices = [...new Set(allChoices)];
        for (let i = uniqueChoices.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [uniqueChoices[i], uniqueChoices[j]] = [uniqueChoices[j], uniqueChoices[i]];
        }

        const finalChoices = uniqueChoices.slice(0, 4);

        // --- 9. SAVE UPDATED STATS (Including Hunger and SP) ---
        const updateLifeParams = [
            finalHp,
            Number(player.xp || 0),
            Number(player.current_level || 1),
            Number(player.max_hp || finalHp),
            Number(player.next_level_xp || 100),
            Number(player.offense || 1),
            Number(player.defense || 1),
            Number(player.hunger), // Added Hunger
            Number(player.sp),     // Added SP
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