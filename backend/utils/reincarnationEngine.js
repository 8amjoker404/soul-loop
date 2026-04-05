const db = require('../config/db');

/**
 * DYNAMIC BIRTH ENGINE
 * Instead of hardcoded values, we let the AI's determined path 
 * and the soul's "resonance" dictate the starting power and location.
 */
const performIsekaiBirth = async (userId, determinedPath, aiSuggestions) => {
    // 1. Check for an existing template
    let [vessels] = await db.execute(
        'SELECT * FROM starting_vessels WHERE soul_path = ? ORDER BY RAND() LIMIT 1',
        [determinedPath]
    );

    let vessel;
    if (vessels.length === 0 || aiSuggestions.forceNew) {
        // 2. DYNAMIC SCALING: AI-driven stats so they don't start "weak"
        // If the soul was heroic, we boost base stats beyond the "newborn" level
        const species = aiSuggestions.species || `${determinedPath} Variant`;
        const location = aiSuggestions.location || 'elroe_upper';
        
        const [insertVessel] = await db.execute(
            `INSERT INTO starting_vessels 
            (soul_path, species, base_hp, base_mp, base_offense, base_defense, base_speed, base_hunger, base_sp, starting_location) 
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [
                determinedPath, 
                species,
                aiSuggestions.hp || 100, // Higher than 50 to avoid "weak" start
                aiSuggestions.mp || 50,
                aiSuggestions.offense || 20, 
                aiSuggestions.defense || 20,
                aiSuggestions.speed || 20,
                100, // Hunger is always full at birth
                aiSuggestions.sp || 50, // Higher stamina for immediate action
                location
            ]
        );
        
        const [newRows] = await db.execute('SELECT * FROM starting_vessels WHERE vessel_id = ?', [insertVessel.insertId]);
        vessel = newRows[0];
    } else {
        vessel = vessels[0];
    }

    return vessel;
};

module.exports = { performIsekaiBirth };