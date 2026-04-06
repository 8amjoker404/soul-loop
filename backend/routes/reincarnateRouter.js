// backend/routes/gameRoutes.js
const express = require('express');
const router = express.Router();
const db = require('../config/db');
const { model } = require('../config/gemini');
const { buildSystemPrompt } = require('../config/prompts');
const { verifyToken } = require('../middleware/auth');
const { performIsekaiBirth } = require('../utils/reincarnationEngine');

// Lock down these routes to authenticated users only
router.use(verifyToken);

// ==========================================
// ROUTE: //api/reincarnate/questions - Handles the entire reincarnation process based on AI judgment of the soul scan answers
// ==========================================
router.get('/questions', async (req, res) => {
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
// ROUTE: //api/reincarnate/ - Handles the entire reincarnation process based on AI judgment of the soul scan answers
// ==========================================
router.post('/', async (req, res) => {
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



module.exports = router;