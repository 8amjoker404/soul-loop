const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');
const { handleAdminCheat } = require('../utils/cheatEngine');
const { scanWorldContext } = require('../utils/worldEngine');
const { calculateCombat, processLevelUp } = require('../utils/gameEngine');

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
// ROUTE 2: REINCARNATE (Fixed after debug)
// ==========================================
router.post('/reincarnate', async (req, res) => {
    const userId = req.user?.userId;
    const { soulChoice } = req.body || {};

    const safeNumber = (value, fallback = 0) => {
        const num = Number(value);
        return Number.isFinite(num) ? num : fallback;
    };

    const safeString = (value, fallback = null) => {
        return value === undefined ? fallback : value;
    };

    try {
        console.log("========== REINCARNATE START ==========");
        console.log("REQ.USER:", req.user);
        console.log("REQ.BODY:", req.body);
        console.log("userId:", userId);
        console.log("soulChoice:", soulChoice);

        if (!userId) {
            console.log("REINCARNATE STOP: userId missing");
            return res.status(401).json({
                error: "[SYSTEM ERROR]: Unauthorized user session."
            });
        }

        if (!soulChoice) {
            console.log("REINCARNATE STOP: soulChoice missing");
            return res.status(400).json({
                error: "soulChoice is required. Use Scavenger, Predator, or Prey."
            });
        }

        // 1. Pull random starting vessel
        const [vesselRows] = await db.execute(
            'SELECT * FROM starting_vessels WHERE soul_path = ? ORDER BY RAND() LIMIT 1',
            [soulChoice]
        );

        console.log("vesselRows:", vesselRows);

        // 2. Fallback vessel
        const startingBody = vesselRows.length > 0 ? vesselRows[0] : {
            species: 'Glitch Slime',
            base_hp: 1,
            base_mp: 1,
            base_offense: 1,
            base_defense: 1,
            base_magic_power: 1,
            base_resistance: 1,
            base_speed: 1,
            starting_location: 'elroe_upper',
            vessel_image: null
        };

        console.log("startingBody raw:", startingBody);

        const species = safeString(startingBody.species, 'Glitch Slime');
        const startingLocation = safeString(startingBody.starting_location, 'elroe_upper');
        const vesselImage = safeString(startingBody.vessel_image, null);

        const baseHp = safeNumber(startingBody.base_hp, 1);
        const baseMp = safeNumber(startingBody.base_mp, 1);
        const baseOffense = safeNumber(startingBody.base_offense, 1);
        const baseDefense = safeNumber(startingBody.base_defense, 1);
        const baseMagicPower = safeNumber(startingBody.base_magic_power, 1);
        const baseResistance = safeNumber(startingBody.base_resistance, 1);
        const baseSpeed = safeNumber(startingBody.base_speed, 1);

        console.log("normalized body:", {
            species,
            startingLocation,
            vesselImage,
            baseHp,
            baseMp,
            baseOffense,
            baseDefense,
            baseMagicPower,
            baseResistance,
            baseSpeed
        });

        // 3. Kill previous life
        const [deathUpdate] = await db.execute(
            'UPDATE current_life SET is_alive = 0 WHERE user_id = ?',
            [userId]
        );
        console.log("old life deactivated:", deathUpdate);

        // 4. Read soul library row if it exists
        const [soulRows] = await db.execute(
            'SELECT * FROM soul_library WHERE user_id = ? LIMIT 1',
            [userId]
        );
        console.log("soulRows:", soulRows);

        const soulData = soulRows.length > 0 ? soulRows[0] : null;

        // 5. Insert new life
        const insertLifeParams = [
            userId,
            species,
            startingLocation,
            baseHp,
            baseHp,
            baseMp,
            baseMp,
            baseOffense,
            baseDefense,
            baseMagicPower,
            baseResistance,
            baseSpeed,
            0,      // xp
            1,      // current_level
            100,    // next_level_xp
            1       // is_alive
        ];

        console.log("insertLifeParams:", insertLifeParams);

        const [resultDb] = await db.execute(
            `INSERT INTO current_life (
                user_id,
                species,
                current_location,
                hp,
                max_hp,
                mp,
                max_mp,
                offense,
                defense,
                magic_power,
                resistance,
                speed,
                xp,
                current_level,
                next_level_xp,
                is_alive
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            insertLifeParams
        );

        console.log("current_life insert result:", resultDb);

        const newLifeId = resultDb.insertId;
        console.log("newLifeId:", newLifeId);

        // 6. Gemini awakening
        const prompt = `
A soul resonates with the ${soulChoice} path.
They awaken as a ${species} in the ${startingLocation}.
Speak in a cold, mechanical system voice.
Describe the awakening and provide exactly 3 short survival choices.
Format:
[CHOICE_1: ...]
[CHOICE_2: ...]
[CHOICE_3: ...]
        `.trim();

        console.log("Gemini prompt:", prompt);

        const result = await model.generateContent(prompt);
        const aiResponse = result?.response?.text?.() || "";

        console.log("aiResponse:", aiResponse);

        const extractedChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
            .map(m => m[1])
            .filter(Boolean);

        const cleanStory = aiResponse.replace(/\[CHOICE_\d+:\s*.*?\]/g, '').trim();

        console.log("extractedChoices:", extractedChoices);
        console.log("cleanStory:", cleanStory);

        const safeChoicesJson = JSON.stringify(extractedChoices || []);
        const safeStory = cleanStory || "You awaken in silence. The system has not yet formed your first guidance.";

        const insertLogParams = [
            newLifeId,
            'System Awakening',
            safeStory,
            safeChoicesJson,
            vesselImage,
            vesselImage
        ];

        console.log("insertLogParams:", insertLogParams);

        // 7. Save awakening log
        const [logInsert] = await db.execute(
            `INSERT INTO action_logs (
                life_id,
                user_action,
                system_response,
                choices,
                bg_image,
                encounter_image
            ) VALUES (?, ?, ?, ?, ?, ?)`,
            insertLogParams
        );

        console.log("action_logs insert result:", logInsert);

        // 8. Final response
        const responsePayload = {
            status: "AWAKENED",
            species_assigned: species,
            soul_path: soulChoice,
            stats: {
                hp: baseHp,
                max_hp: baseHp,
                mp: baseMp,
                max_mp: baseMp,
                offense: baseOffense,
                defense: baseDefense,
                magic_power: baseMagicPower,
                resistance: baseResistance,
                speed: baseSpeed,
                xp: 0,
                current_level: 1,
                next_level_xp: 100,
                location: startingLocation
            },
            permanent_skills: soulData?.permanent_skills ?? null,
            system_output: safeStory,
            choices: extractedChoices,
            visuals: {
                background: vesselImage,
                entity: vesselImage
            }
        };

        console.log("REINCARNATE SUCCESS RESPONSE:", responsePayload);
        console.log("========== REINCARNATE END ==========");

        return res.json(responsePayload);

    } catch (err) {
        console.error("========== REINCARNATE ERROR ==========");
        console.error("message:", err.message);
        console.error("stack:", err.stack);
        console.error("full error:", err);
        console.error("========== REINCARNATE ERROR END ==========");

        return res.status(500).json({
            error: "[SYSTEM ERROR]: Reincarnation stream interrupted.",
            details: err.message
        });
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
            return res.status(400).json({
                error: "action is required."
            });
        }

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

        // --- 1. CHEAT ENGINE CHECK ---
        const cheatCheck = await handleAdminCheat(normalizedAction, player, userId);

        if (cheatCheck.isCheat) {
            return res.json(cheatCheck.response);
        }

        // --- 2. WORLD ENGINE SCAN ---
        const worldData = await scanWorldContext(player, userId);

        // --- 3. COMBAT ENGINE LOGIC ---
        let engineNotice = "";
        let monsterContext = "";
        let monsterButtons = [];
        let monsterImageUrl = null;

        const [spawns] = await db.execute(`
            SELECT m.* 
            FROM zone_spawns z 
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

                engineNotice = `[ENGINE_COMBAT]: Dealt ${result.damageDealt} DMG. ${
                    result.isMonsterDead ? 'Slain.' : 'Survived.'
                } Gained ${result.xpGained} XP.`;
            } else {
                monsterContext = `[ENCOUNTER: WILD ${m.name} (${m.danger_rank})]. ${m.description}. `;
                monsterButtons.push(`Attack the ${m.name}`);
            }
        }

        // --- 4. LEVEL ENGINE ---
        const levelData = processLevelUp(player);

        if (levelData.leveledUp) {
            Object.assign(player, levelData);
            engineNotice += ` ${levelData.systemLog}`;
        }

        // --- 5. VISUALS & AI NARRATION ---
        const [locRows] = await db.execute(
            'SELECT location_image FROM location_seeds WHERE location_id = ?',
            [player.current_location]
        );

        const backgroundUrl = locRows.length > 0 ? locRows[0].location_image : null;

        const fullContext = `${worldData.pvpContext || ""}${monsterContext}${worldData.worldLore || ""}${engineNotice}`;

        const aiPrompt = buildSystemPrompt(
            player,
            { description_seed: player.current_location },
            normalizedAction,
            fullContext
        );

        const aiResult = await model.generateContent(aiPrompt);
        const aiResponse = aiResult?.response?.text?.() || "";

        // --- 6. PARSING & DB FINALIZATION ---
        let finalHp = Number(player.hp || 0);
        let isAlive = true;

        const hpM = aiResponse.match(/\[HP_SET:\s*(\d+)\]/);
        if (hpM) {
            finalHp = parseInt(hpM[1], 10);
        }

        if (finalHp <= 0 || aiResponse.includes("[STATUS: DECEASED]")) {
            isAlive = false;
            finalHp = 0;
        }

        const aiChoices = [...aiResponse.matchAll(/\[CHOICE_\d+:\s*(.*?)\]/g)]
            .map(m => m[1])
            .filter(Boolean)
            .map(choice => String(choice).trim());

        const allChoices = [
            ...(worldData?.pvpButtons || []),
            ...monsterButtons,
            ...aiChoices
        ]
            .filter(Boolean)
            .map(choice => String(choice).trim());

        const uniqueChoices = [...new Set(allChoices)];

        for (let i = uniqueChoices.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [uniqueChoices[i], uniqueChoices[j]] = [uniqueChoices[j], uniqueChoices[i]];
        }

        const finalChoices = uniqueChoices.slice(0, 4);

        const updateLifeParams = [
            finalHp,
            Number(player.xp || 0),
            Number(player.current_level || 1),
            Number(player.max_hp || finalHp),
            Number(player.next_level_xp || 100),
            Number(player.offense || 1),
            Number(player.defense || 1),
            isAlive ? 1 : 0,
            player.life_id
        ];

        await db.execute(
            `UPDATE current_life 
             SET hp = ?, xp = ?, current_level = ?, max_hp = ?, next_level_xp = ?, offense = ?, defense = ?, is_alive = ? 
             WHERE life_id = ?`,
            updateLifeParams
        );

        const cleanStory = aiResponse.replace(/\[.*?\]/g, '').trim();

        const logParams = [
            player.life_id,
            normalizedAction,
            cleanStory,
            JSON.stringify(finalChoices),
            backgroundUrl,
            monsterImageUrl
        ];

        await db.execute(
            `INSERT INTO action_logs (
                life_id,
                user_action,
                system_response,
                choices,
                bg_image,
                encounter_image
            ) VALUES (?, ?, ?, ?, ?, ?)`,
            logParams
        );

        const responsePayload = {
            status: isAlive ? "ALIVE" : "DEAD",
            stats: {
                hp: finalHp,
                max_hp: player.max_hp,
                level: player.current_level,
                xp: player.xp,
                next_mark: player.next_level_xp
            },
            system_output: cleanStory,
            choices: finalChoices,
            visuals: {
                background: backgroundUrl,
                entity: monsterImageUrl
            }
        };

        return res.json(responsePayload);

    } catch (err) {
        return res.status(500).json({
            error: "System Error.",
            details: err.message
        });
    }
});



module.exports = router;