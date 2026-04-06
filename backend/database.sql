-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 06, 2026 at 07:11 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soul_loop_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `action_logs`
--

CREATE TABLE `action_logs` (
  `log_id` int(11) NOT NULL,
  `life_id` int(11) DEFAULT NULL,
  `user_action` text DEFAULT NULL,
  `system_response` text DEFAULT NULL,
  `choices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`choices`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `bg_image` varchar(255) DEFAULT NULL,
  `encounter_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `action_logs`
--

INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(2, 9, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[SCANNED ENVIRONMENT: ELROE_UPPER_STRATUM]\n[BIOLOGICAL ANCHOR DETECTED: CAVE CENTIPEDE (JUVENILE)]\n[SOUL RESONANCE: SCAVENGER]\n\n...\n...\n\n**[ERROR: SENSORY INPUT OVERLOAD]**\n\nA jagged, segmented existence replaces the abstraction of thought. You do not wake up; you *click* into being. The world is a cacophony of vibrations scraping against your chitinous plating. You are not breathing—you are respiring through spiracles that taste the metallic, damp air of the labyrinth. \n\nYour vision is a mosaic of flickering, low-resolution heat signatures. You possess forty legs, and for a terrifying moment, your consciousness fails to coordinate them, resulting in a frantic, uncoordinated thrashing against the cold, damp stone. You are hungry—a hollow, corrosive ache that pulses in rhythm with your frantic, multiple hearts. You are a predator that feeds on carrion, a scavenger of the deep, and your instincts are screaming for sustenance.\n\nYou are small. You are vulnerable. The ceiling above you drips with bioluminescent moss, casting long, sickening shadows that pulse like a warning.\n\n***\n\n[SYSTEM QUERY: MANDATORY DIRECTIVE]\n[PATH: SCAVENGER]\n[ACTION REQUIRED]\n\n**CHOICE 1: [THE HUNGRY VIGIL]**\nRemain perfectly still, pressing your segmented body into a crevice in the stone. Use your vibration-sensing antennae to map the surroundings. Wait for the tell-tale scent of decay from a larger creature’s kill, rather than risking a confrontation in your current, uncoordinated state.\n\n**CHOICE 2: [THE CHAOTIC SCURRY]**\nPanic-reflex triggers. Force your legs into motion, bolting blindly into the dark labyrinth. Trust in your natural speed to outrun whatever nightmare inhabits this chamber, hoping to stumble upon a discarded carcass or a softer, less-guarded creature to consume.\n\n**CHOICE 3: [THE PREDATORY AMBUSH]**\nAnalyze the immediate vicinity for movement. Locate a tunnel junction and wedge yourself into the shadows above the path. Prepare to drop upon the first small insect or subterranean crawler that passes beneath you, attempting to establish dominance and satisfy the gnawing void in your core immediately.', NULL, '2026-04-03 18:39:12', NULL, NULL),
(3, 10, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE.]\n[SOUL INTEGRATION: SUCCESSFUL.]\n[PATH DETERMINED: SCAVENGER.]\n\n[ALERT: SENSORY INPUT OVERLOAD DETECTED.]\n[VISION: MULTI-FACETED ARRAY DETECTED. MAPPING SPATIAL COORDINATES...]\n[ENVIRONMENT: ELROE_UPPER_STRATA. AMBIENT TEMPERATURE: 12°C. HUMIDITY: 45%.]\n[PHYSICAL STATUS: 8 LEGS DETECTED. CHITINOUS EXOSKELETON: FRAGILE. MANA RESERVES: NEGLIGIBLE.]\n\n[ERROR: BIOLOGICAL UNIT UNSTABLE. HUNGER DETECTED: 88%.]\n[PROMPTING FOR IMMEDIATE DIRECTIVE.]\n\n***\n\n**[CHOOSE YOUR PRIMARY INSTINCT]**\n\n**1. [AGGRESSIVE SCAVENGING]**\n*   Prioritize mobility and combat readiness. Use the environment to stalk small prey, regardless of the caloric risk. Focus on physical growth and predatory efficiency.\n\n**2. [CAUTIOUS CONSUMPTION]**\n*   Prioritize survival and stealth. Retreat into the labyrinthine shadows of the Elroe upper levels. Seek out carrion or weakened organisms to minimize energy expenditure while mapping the local ecosystem.\n\n**3. [ENVIRONMENTAL ADAPTATION]**\n*   Prioritize structural integrity. Begin spinning silk immediately to create a defensive web-nest. Focus on defensive utility and securing a stationary perimeter to observe the dangers of the upper strata before moving.', NULL, '2026-04-03 18:40:16', NULL, NULL),
(4, 10, 'I cautiously explore the dark cave, not knowing what do because i dont even knw what i am ', 'The darkness is absolute. Your multifaceted eyes struggle to adjust to the oppressive gloom of the limestone cavern. You move on eight chitinous limbs, the clicking of your joints echoing sharply against the damp walls. Your instincts are nascent, a flicker of hungry confusion in a fragile body. \n\nAs you navigate a narrow crevice, a sticky, silken strand brushes against your thorax. The texture is familiar—it is your own thread. You are a Small Lesser Taratect, a creature woven from malice and silk.\n\nHigh above the labyrinth, a detached consciousness observes your clumsy gait. A digital ripple echoes through your mind, a faint, mocking transmission from the System: *[SYSTEM INTERCEPT]: Subject \'D\' has adjusted the gaze. A new variable has been introduced to the floor. The game continues.*\n\nYou feel a sudden spike of adrenaline as you realize the shadows ahead hold the faint, rhythmic breathing of something larger.\n\n\n\n\n**Choices:**\n1. Advance toward the source of the breathing to investigate.\n2. Retreat and find a high crevice to weave a protective web-nest.\n3. Remain perfectly still and attempt to sense the movements in the dark.', NULL, '2026-04-03 18:45:25', NULL, NULL),
(5, 10, 'how about i saw a dark like oil and use my web and use it to mask my self', 'The damp limestone walls of the Upper Elroe Labyrinth weep a viscous, pitch-black secretion. You approach a pool of this dark, oil-like substance, dipping your silk strands into the sludge. As you coat your body in the mire, the sticky threads bind the dark liquid to your exoskeleton, effectively camouflaging your presence against the cavern shadows.\n\n\n\n\n\n[SYSTEM INTERCEPT]: A low-frequency vibration tremors through the stone floor nearby. Intelligence reports suggest an Earth Dragon, Feirune, is roaming a neighboring tunnel, hungry and oblivious to your presence. The air grows heavy with the scent of predatory intent.', NULL, '2026-04-03 19:15:54', NULL, NULL),
(6, 10, 'Anchor silk above and slowly ascend into the upper crevice, moving against gravity to avoid ground vibrations.', 'The silk strands adhere to the jagged limestone ceiling with a faint, sticky snap. Utilizing Thread Manipulation, you pull your small, arachnid frame upward, defying gravity as you ascend into the dark, moisture-slicked crevice. The ground below—a hotbed of territorial predators and shifting debris—recedes into the gloom. You remain suspended, motionless, an observer in the labyrinthine shadows.\n\n[SYSTEM INTERCEPT]: A flicker of data pulses through the void. Subject \'D\' adjusts the viewport. The Labyrinth remains a game board, and the pieces are moving.\n\nYour movements are precise, though the physical exertion takes a toll on your limited stamina. You are learning the architecture of the dungeon; the way the silk catches the ambient humidity provides a sense of security against the prowling threats of the lower strata.', '[\"Scout the ceiling passage for a hidden nest or potential prey.\",\"Remain suspended in the crevice and wait for a passing monster to ambush from above.\",\"Carefully traverse the ceiling toward the sound of trickling water in the distance.\"]', '2026-04-03 19:25:55', NULL, NULL),
(7, 11, 'System Awakening', '**SYSTEM INITIALIZATION: COMPLETE.**\n**UNIT DESIGNATION:** SCRAP SLIME.\n**LOCATION:** ELROE_UPPER, SUB-LEVEL 7.\n**PATH ALIGNMENT:** SCAVENGER.\n\n**[CORE LOG]:** Awakening detected. Sensory input: fragmented. Neural pathways: re-routing.\n**[WARNING]:** Biological structural integrity is… amorphous. The concept of ‘limbs’ is missing. You are a cohesive mass of semi-viscous, metallic-infused protoplasm. You exist in the shadows of the Elroe Great Labyrinth. Around you, the refuse of forgotten adventurers—rusted iron, shattered glass, and calcified bone—pulsates with the faint, residual mana of the Upper Strata. \n\nYou do not have lungs, yet you \'breathe\' the stagnant, mineral-heavy air. You do not have eyes, yet you \'perceive\' the molecular weight of the debris surrounding your gelatinous form. \n\n**[SYSTEM QUERY]:** How shall the Scavenger manifest?\n\n**CHOICE 1: Assimilate the Immediate.** \nAbsorb the rusted iron shards littering your spawn point. Integrate the metal into your slime-structure to increase density and defense, sacrificing mobility for durability.\n\n**CHOICE 2: Hunt the Residue.** \nExtend sensory pseudopods into the cracks of the stone floor to detect lingering mana signatures. Search for a discarded adventurer’s pouch or an abandoned potion flask. Prioritize rapid growth through consumption of magical waste.\n\n**CHOICE 3: Instinctual Evasion.** \nSense the vibrations of the environment. Something large is moving through the tunnels nearby. Mimic the texture and color of the surrounding stone to avoid early-stage predation. Prioritize survival over immediate expansion.\n\n**[AWAITING INPUT...]**', NULL, '2026-04-03 20:40:13', NULL, NULL),
(8, 12, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE]\n[SUBJECT STATUS: AWAKENED]\n[BIOLOGICAL CLASSIFICATION: LESSER FIRE WYRM (JUVENILE)]\n[LOCATION: MAGMA_LAYER_SECTOR_04]\n[ENVIRONMENTAL HAZARD: EXTREME THERMAL DENSITY DETECTED]\n\n[ERROR: NEURAL MAPPING INCOMPLETE]\n[WARNING: INSTINCTUAL OVERRIDE DETECTED]\n[LOG: CONSCIOUSNESS DETECTED WITHIN ORGANIC VESSEL. MOTOR FUNCTIONS RESPONDING TO PREDATORY PRIMAL DRIVES. ANALYTICAL PROCESSING IS CURRENTLY INTERFERING WITH BIOLOGICAL IMPULSES.]\n\nYou are curled within a cradle of cooling basalt and liquid rock. Your scales—obsidian-black and searing to the touch—clatter against the stone as you shift. The air tastes of sulfur and raw kinetic energy. Your vision is split: one input registers the physical world through heat-vision, flickering in shades of blinding white and deep violet; the other input is a scrolling, sterile stream of data reporting your own hunger, your internal temperature, and the proximity of potential biomass. \n\nA primal roar bubbles in your throat, but it is accompanied by a text-prompt in your mind. The system demands an immediate calibration of your predatory instincts.\n\n**CHOOSE YOUR PRIMARY EVOLUTIONARY FOCUS:**\n\n**[A] CONSUME THE CRUST:** Direct all sensory input toward the magma flow. Digest the surrounding rock and thermal energy to rapidly expand your physical frame. *Trade-off: High growth potential, low immediate mobility.*\n\n**[B] SEEK THE VIBRATION:** Ignore the hunger and focus on the tremors in the distance. Hunt for the entity producing rhythmic vibrations in the rock. *Trade-off: High lethality/tactical experience, risk of environmental exposure.*\n\n**[C] RECALIBRATE INSTINCTS:** Attempt to bypass the mechanical interface and synchronize your soul with the Wyrm’s biological mind. *Trade-off: Slow initialization, potential to stabilize the mental dissonance and unlock hidden draconic capabilities.*', NULL, '2026-04-03 20:40:30', NULL, NULL),
(9, 13, 'System Awakening', '[SYSTEM INITIALIZATION COMPLETE]\n[PATH IDENTIFIED: PREY]\n[ENTITY DESIGNATION: BLIND CAVE SALAMANDER]\n[BIOME: WATER_STRATUM]\n\nAwakening sequence initiated. Sensory input: Null (Ocular atrophy detected). Tactile input: High-velocity mineral-rich current. Chemical input: Nutrient-dense biofilm, predatory pheromones detected in proximity. The vessel is frail, translucent, and prone to rapid dehydration. Integration of biological instincts: Active. Survival probability: Negligible.', '[\"Anchor to the submerged limestone crevice to minimize metabolic expenditure.\",\"Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.\",\"Initiate passive filter-feeding along the cave floor to restore internal energy reserves.\"]', '2026-04-04 15:27:32', NULL, NULL),
(10, 13, 'Deploy sensory vibration-sensitive whiskers to scan for nearby cavern predators.', 'The sensory organs ripple, pushing through the stagnant, mineral-rich water of the stratum. Silence reigns, save for the rhythmic dripping of stalactites. \n\nThe vibrations return. A low-frequency pulsing emanates from the northern corridor—a rhythmic, dragging motion indicating a Cave Creeper, blind and starving. Your whiskers register the ripple of its displacement in the water. Far above the stone ceiling, a faint, phantom resonance of a  broadcast hums through the rock—a report of a soul at the Royal Academy unlocking . The disparity is vast. You are mud and instinct; they are light and ambition. The Creeper shifts closer, hungry.', '[\"Challenge light to a Duel\",\"Remain motionless to avoid detection and let the creature pass.\",\"Use the newly acquired skill to track the creature\'s path and ambush it.\",\"Flee into the deeper, uncharted fissures of the water_stratum.\"]', '2026-04-04 15:41:14', NULL, NULL),
(11, 13, 'Remain motionless to avoid detection and let the creature pass.', 'The water in the stratum ripples with a heavy, rhythmic turbulence. A massive, bioluminescent predator glides inches above your submerged form, its jagged scales scraping against the cavern floor. You hold your breath, your damp skin blending into the mineral-rich sediment. The scent of ozone and ancient magic lingers in the water—a faint, lingering byproduct of a soul elsewhere in the world tapping into the  recently reported in the Royal Academy broadcasts. The predator senses nothing but cold stone. It drifts onward, disappearing into the dark throat of the abyss.\n\nSafety is achieved, but the stillness drains your vitality. You are small, fragile, and utterly alone in the deep.', '[\"Challenge light to a Duel\",\"Search the immediate sediment for bioluminescent fungi to consume.\",\"Swim toward the faint light emanating from a distant, upward-sloping tunnel.\",\"Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.\"]', '2026-04-04 15:46:02', NULL, NULL),
(12, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The water in the stratum remains stagnant, clinging to your translucent, sightless skin like a shroud. You channel your internal essence toward your lateral line and nasal receptors, pushing past the threshold of mere instinct. The world does not brighten, but it clarifies; the oppressive silence fractures into a complex map of tectonic tremors and the rhythmic drip of calcified stalactites.\n\nAs your senses bloom, a jagged psychic resonance ripples through the cavern—a stray signal from the Surface. *.]* The triviality of their achievements feels distant, a flare of warmth in a world of absolute zero. The strain of sensory expansion causes your fragile tissues to throb, leaving you slightly drained.', '[\"Challenge light to a Duel\",\"Follow a faint, rhythmic vibration echoing from the deeper, darker reaches of the tunnel.\",\"Remain stationary and attempt to conserve energy, waiting for potential prey to drift into range.\",\"Navigate toward the surface of the pool, seeking to investigate the air-breathing alcoves above.\"]', '2026-04-04 15:47:19', NULL, NULL),
(13, 13, 'Use your remaining energy to sharpen your sensory organs, attempting to perceive the vibrations of the surrounding tunnels.', 'The lightless expanse of the water stratum shudders. You push your internal essence outward, straining your damp, pale nerves against the stagnant stillness of the cavern. The water ripples, carrying the whispers of the earth. You feel the heavy, rhythmic thrum of distant crushing stone and the erratic, high-frequency agitation of something skittering along the cavern roof.\n\nA broadcast flickers across your consciousness, cold and detached: ** \n\nAs your senses bloom, the vibrations coalesce into a mental map of the nearby currents. You have evolved beyond mere instinct.', '[\"Challenge light to a Duel\",\"Follow the skittering vibrations toward the cavern ceiling to hunt.\",\"Remain still in the water, conserving energy while monitoring the nearby tunnel junction.\",\"Dive deeper into the submerged crevice to avoid whatever entity just broadcasted its presence.\"]', '2026-04-04 15:48:11', NULL, NULL),
(14, 13, 'Remain still in the water, conserving energy while monitoring the nearby tunnel junction.', 'The water of the subterranean pool is still, mirroring the oppressive darkness of the cavern. You anchor yourself against a jagged limestone formation, your translucent skin cooling as you wait. Above the water\'s surface, the air grows thin and humid. \n\nFaint vibrations ripple through the cavern floor—the rhythmic, tectonic shifting of a creature far more massive than yourself. From the nearby tunnel junction, a flick of heat emanates, signaling the proximity of the Lesser Fire Wyrm known as \'joker.\' The System broadcasts a silent, mocking vibration into your primitive sensory organs: *“Two sparks in the dark, yet only one shall illuminate the path to evolution.”* You remain undetected, your stillness granting you a reprieve from the predator\'s gaze.', '[\"Threaten joker\",\"Slowly creep toward the tunnel junction to ambush the Fire Wyrm while it is distracted.\",\"Ignore joker for now\",\"Swim deeper into the subterranean lake to avoid the proximity of the Fire Wyrm.\"]', '2026-04-04 15:55:06', NULL, NULL),
(15, 13, 'Ignore joker for now', 'The icy currents of the water_stratum offer a sanctuary of silence. You glide through the mineral-rich darkness, distancing yourself from the heat signature radiating from the cavern above. The Lesser Fire Wyrm, Joker, remains oblivious to your path, his hunger currently focused on the cavern floor miles away. A telepathic tremor vibrates through the stone; the System broadcasts a whisper of his violent descent into the upper labyrinth, but you press deeper into the subterranean pools, preserving your vitality.', '[\"Search the submerged floor for nutrient-dense moss to recover HP.\",\"Ignore joker for now\",\"Navigate deeper into the uncharted tunnels of the water_stratum.\",\"Surface slightly to listen for the movements of other souls.\"]', '2026-04-04 15:55:31', NULL, NULL),
(16, 14, 'System Judgment Awakening', 'Identity synchronization verified. The ambient mana of the royal capital brushes against your physical vessel, cold and indifferent. You stand amidst the sprawling white stone architecture of the central plaza, a drop of water in an ocean of unfamiliar souls.\n\nA discordant pulse ripples through the air—a system-wide broadcast vibrates in your mind: *“Data anomaly detected in sector 4. Another soul from the void has manifested.”* The local populace continues their transit, entirely oblivious to the predatory resonance emanating from your core. You are a ghost inhabiting a mannequin, and the world is beginning to notice the displacement.', '[\"Attempt to blend into the passing crowd to observe the capital\'s social structure.\",\"Seek a secluded alleyway to test the limits of your new physical form.\",\"Approach a nearby merchant to gather information regarding your current location and status.\"]', '2026-04-05 15:38:31', NULL, NULL),
(17, 15, 'System Judgment Awakening', 'The jagged, light-starved labyrinth of the Elroe Upper Stratum stretches infinitely in all directions. Your consciousness flickers into existence, anchored to the fragile, leathery frame of a Shadow Bat. The air here is stagnant, thick with the scent of subterranean decay and the distant skittering of predatory chitin on stone. \n\nSystem broadcast intercepted: *Anomalous soul-signature detected in the lower sector. Correlation with \'Reincarnator\' status confirmed. The weave of causality tightens.*\n\nYou hang inverted from a stalactite, your sensitive ears twitching at the sound of fluid dripping into a dark pool far below. Hunger gnaws at your core; your existence is a momentary spark in the crushing dark.', '[\"Drop from the ceiling and scout the immediate vicinity for sustenance.\",\"Remain suspended in silence to observe the movement patterns of nearby entities.\",\"Take flight into the deeper tunnels to map the local geography.\"]', '2026-04-05 15:39:41', NULL, NULL),
(18, 15, 'Take flight into the deeper tunnels to map the local geography..', 'The Shadow Bat unfurls its translucent, ink-stained wings, catching a draft of stale, dungeon air. As you bank away from the Small Lesser Taratect—which snaps its mandibles at empty air where you once hung—you ascend into the jagged, upper reaches of the Elroe Labyrinth. \n\nThe darkness here is thick, a velvet shroud that your kin find comforting. Below, the distant skittering of arachnid legs echoes against the stone. A flicker of data pulses in your mind: ** You navigate a series of narrow crevices, your sonar pinging off walls of raw ore and ancient sediment. The effort of sustained flight consumes your reserves.\n\n\n\n\n---', '[\"Challenge light to a Duel\",\"Attack the Small Lesser Taratect\",\"Continue mapping the tunnels, searching for a water source.\",\"Observe light carefully\"]', '2026-04-05 15:49:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(19, 15, 'Attack the Small Lesser Taratect.', 'The shadow cast by your wings flickers against the cavern walls of Elroe Upper. You dive, talons extended, latching onto the carapace of the Small Lesser Taratect. It hisses, a chittering sound that vibrates through your hollow bones. A brief struggle ensues; you tear into its chitinous hide, and the creature goes limp.\n\n: A distant, distorted broadcast echoes in the frequency of the labyrinth: *“The favored of the gods hone their craft in white marble halls, wielding holy light. You remain in the dark.”* \n\nThe effort leaves you winded, your own life-force thinned by the skirmish.', '[\"Threaten light\",\"Scan the surroundings\",\"Consume the carcass to restore vitality.\",\"Scout the immediate area for the source of the PVP detection.\"]', '2026-04-05 15:50:43', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(20, 15, 'Consume the carcass to restore vitality.', 'The jagged, obsidian landscape of the Elroe Labyrinth reflects a cold, uncaring light. You descend upon the remains of the frog, your claws tearing into the acidic, rubbery flesh. The consumption is swift, a desperate act of survival that numbs your senses as the creature\'s essence permeates your own.\n\nAs you feed, the system hums—a distant, distorted broadcast echoing through the cavern walls: *“Observation of the subterranean struggle continues. An anomaly—a soul from another world—lingers in the light nearby, oblivious to the predator currently feasting in the shadows.”*\n\nYour vitality stabilizes, though the chemical burn of the prey leaves a foul taste.', '[\"Threaten light\",\"Stay alert and do nothing\",\"Investigate the nearby light source to confront the other soul.\",\"Deepen your concealment within the shadows to avoid detection.\"]', '2026-04-05 15:51:34', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(21, 15, 'Stay alert and do nothing', 'Attention: A biological anomaly of note has been registered. Within the Royal Academy, a subject has successfully integrated . The System classifies this development as high-priority; monitor evolution paths accordingly.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nStatus: Stationary/Alert.\n\nSubject has opted for a period of quiescence. Efficiency of energy expenditure is high; however, metabolic processes continue to deplete resources. With SPD at 18, the subject remains primed for rapid kinetic response, though minimal movement prevents the replenishment of SP. Current Hunger levels are within optimal parameters for continued predation; however, prolonged stasis will induce a net negative in caloric storage. Environment remains hostile; vigilance is maintained, but no developmental progress is observed.\n\n\n\n---', '[\"Attempt to manipulate ambient mana to stimulate MAG development.\",\"Relocate to a higher-elevation cavern wall to conserve SP.\",\"(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.\"]', '2026-04-06 03:04:54', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(22, 15, '(PREDATOR) Initiate a sweep of the immediate perimeter to track potential prey.', '- Labyrinth Observation Status: ACTIVE. The System notes an increase in biological volatility within Elroe Upper. Entities are currently being monitored for entertainment value. Efficiency remains the primary metric for continued survival.\n\n---\n\n\nSubject: Shadow Bat (Level 1)\nAction: Perimeter Sweep initiated.\n\nAnalysis: Subject utilized base SPD attribute of 18 to navigate the immediate environment with high-frequency velocity. This mobility resulted in an effective scanning radius of 15 meters. While SPD metrics allow for rapid displacement, the current SP level (10/20) indicates moderate fatigue, limiting the duration of this high-speed output.\n\nBiological Anomaly Detected: Subject’s Hunger level (78/100) is currently optimal for metabolic maintenance. No debuffs detected. Subject successfully tracked a small cavern rodent behind a quartz formation. Success probability of intercept: 84%.\n\n\n\n\n---', '[\"(SCOUT) Conserve remaining SP by maintaining a stealth-based observation of the surrounding tunnels.\",\"(ADAPT) Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.\",\"(PREDATOR) Execute a high-speed ambush on the detected rodent to secure caloric intake.\"]', '2026-04-06 03:15:01', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(23, 15, 'Attempt to consume nearby bio-luminescent moss to test for potential nutritional supplementation.', 'The upper strata of Elroe are characterized by cold, damp mineral walls and the faint, rhythmic dripping of condensation. The air smells of stagnant ozone and pulverized limestone. You descend from your perch, your claws clicking against the jagged cavern ceiling before you land silently amidst the blue-tinged, bio-luminescent moss. The temperature here is a biting 8°C.\n\nYou ingest a portion of the flora. Its texture is fibrous and rubbery, emitting a bitter, metallic taste that coats your tongue. Your MAG stat of 5 fails to register any magical properties, and your resistance proves sufficient to neutralize the mild toxins within the plant. Nutritional yield is minimal.\n\n\n\nThe silence of the upper labyrinth is deceptive; deep within the stone, the chittering of larger, chitinous predators vibrates through the floor. Your Stamina is critically depleted, and the cold is accelerating your caloric burn.', '[\"(PREDATOR) Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal. (Cost: High SP, Med Hunger)\",\"(Explore) Scout deeper into the tunnel to locate a more substantial water source. (Cost: Low SP)\",\"(Risky Action) Scale the unstable, wet wall to reach a higher, warmer thermal vent. (Cost: High HP Risk)\"]', '2026-04-06 03:38:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(24, 15, 'Ambush the small, glowing insectoid attracted to the moss for a protein-dense meal.', 'The air in the Elroe Upper is thick with the scent of damp fungi and decaying organic matter. You launch yourself from the shadow of a stalagmite, utilizing your high SPD stat to close the distance before the insectoid’s primitive compound eyes can process the threat. Your talons pin the glowing organism against the bioluminescent moss. The crunch of the carapace is audible, followed by the fluid intake of essential nutrients. The prey is consumed in seconds, providing a momentary abatement of your metabolic deficit.\n\nHowever, the rapid movement in your current state of exhaustion has triggered a system warning. Your lack of stamina is hindering further potential. Nearby, the rhythmic clicking of a Small Lesser Taratect echoes against the stone walls—the predator is hunting, and it is closer than calculated.\n\n\n\n\n---', '[\"(Risky Action) Dash across the open cavern floor to reach a higher, safer altitude. (Cost: High SP, Risk of Detection)\",\"(Rest) Conserve energy by hunkering down in the shadows of the mossy crevice. (Cost: Low SP recovery)\",\"Attack the Small Lesser Taratect\",\"(PREDATOR) Stalk the source of the nearby clicking to secure a more substantial kill. (Cost: High SP, Low Hunger)\"]', '2026-04-06 03:39:22', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(25, 15, 'Attack the Small Lesser Taratect', 'The damp, frigid air of the Elroe Upper Labyrinth clings to your fur as you lunge. Your SPD attribute of 18 gives you the advantage, allowing you to bypass the Small Lesser Taratect’s clumsy defensive posture. You strike with your ATK, tearing through its chittering mandibles before the creature can solidify its web. The metallic tang of hemolymph fills the narrow, stone-walled corridor. You have secured the kill, but your own reserves are rapidly depleting.\n\n\n\n\n\n\n**Survival Status:** Your metabolic deficit is reaching critical thresholds. The exhaustion penalty to your SPD is hindering your ability to navigate the labyrinth’s vertical terrain.', '[\"(PREDATOR) Hunt for a larger target to satisfy your ravenous hunger. (Cost: High SP, Med Hunger)\",\"(Consume) Eat the defeated Taratect to stabilize your biological state. (Cost: Low Time)\",\"(Forage) Scour the cavern walls for edible moss or insects. (Cost: High HP Risk - Ambush Potential)\"]', '2026-04-06 03:40:14', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(26, 15, 'Eat the defeated Taratect to stabilize your biological state', '---\n\n**NARRATION**\nThe damp, stagnant air of the Elroe Upper Labyrinth clings to your fur, thick with the scent of chitin and subterranean decay. You descend upon the mangled carapace of the Taratect. Your SPD attribute, hampered by systemic exhaustion, makes the movement sluggish, but your ATK stat is sufficient to tear through the cooling exoskeleton. \n\nAs you consume the biological matter, the caustic, metallic taste of Taratect ichor floods your senses. It is inefficient, difficult to digest, but the raw caloric intake stabilizes your crashing vitals. Your biological anomaly of a body registers the caloric shift. However, the labyrinth is vast, cold, and indifferent; the sound of skittering legs echoing in the distance suggests that a carcass—and the scavenger feeding upon it—does not remain unobserved for long.\n\n\n\n\n\n**CURRENT SURVIVAL STATUS:** The immediate caloric crisis is averted, but the exhaustion remains. Your SPD is compromised, making you a target for larger predators within the Upper Labyrinth.\n\n---', '[\"(PREDATOR) Drag the remaining carcass into the shadows to continue feeding and regain full stamina. (Cost: Med SP, Low Hunger)\",\"(Rest) Find a crevice in the wall and enter a torpor state to recover SP. (Cost: Low Hunger)\",\"(Risky Action) Navigate deeper into the maze while weakened, searching for a water source. (Cost: High HP Risk)\"]', '2026-04-06 03:40:44', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(27, 15, 'Drag the remaining carcass into the shadows to continue feeding and regain full stamina', 'The Elroe Upper Labyrinth is humid, the air heavy with the scent of damp moss and the metallic tang of dried insectoid ichor. The cavern walls, slick with condensation, offer little traction, yet your high SPD (18) allows for fluid, silent movement through the shadows. \n\n\nThe hatchling spider remains oblivious near a fissure in the rock, its mandibles clicking rhythmically. Its presence registers as a biological anomaly to be processed.\n\n---\n\n\nYou clamp your jaws firmly into the sinew of the remaining carcass. The act of dragging it is hindered by your current state of exhaustion; your wings feel like leaden weights, and your muscles spasm as your SP sits at a critical 0. You retreat into the deepest shroud of the labyrinth, where the light of the phosphorescent fungi barely reaches. \n\nTearing into the flesh, the caloric intake is immediate. The biological efficiency of your consumption is high, though your movement is sluggish. Each bite provides a momentary reprieve from the metabolic collapse threatening your system. However, the scent of the blood attracts unwanted attention; the Lesser Taratect nearby pauses, its multi-faceted eyes turning toward your position. The humidity of the cave clings to your fur as you feed, the silence broken only by your ragged breathing and the rhythmic chewing of your prey.\n\n\n\n\n\n---', '[\"(PREDATOR) Launch a surprise aerial ambush on the Lesser Taratect to secure a secondary food source before the exhaustion fully locks your joints. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to intimidate the hatchling with a screech to drive it away before it identifies you as a threat. (Cost: High HP Risk)\",\"(Hide) Cease feeding and press yourself against the rock face to wait for the spider to wander off. (Cost: Low SP)\",\"Attack the Small Lesser Taratect\"]', '2026-04-06 04:03:50', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(28, 15, 'Attack the Small Lesser Taratect', '.]\n\n\nThe humidity of Elroe Upper clings to your wings, a thick, stagnant warmth that smells of damp minerals and decay. Ahead, a Small Lesser Taratect skitters across the uneven cavern floor, its multi-faceted eyes reflecting the faint, bioluminescent moss clinging to the walls. \n\nYou lunged. Relying on your SPD of 18, you banked off the slick stone, your form a blur in the dim light. The Taratect reacted, its legs twitching as it attempted to weave a web, but your agility proved superior. Your fangs, driven by an ATK of 7, bypassed the creature\'s meager DEF of 4. You slammed into its thorax, the sound of chitin cracking resonating through the chamber. Green ichor erupted, spraying the cold floor as the creature collapsed, its defensive maneuvers failing against your predatory precision. The threat is neutralized.\n\n\n\nThe exertion of the strike has left you panting; the air in the upper stratum is thin, and your stomach churns with a hollow ache. Every second spent in this cavern accelerates your biological degradation.\n\n\n\n\n\n---', '[\"(Risky Action) Venture deeper into the nest to find higher-quality sustenance, risking potential detection by an adult variant. (Cost: High HP Risk)\",\"(PREDATOR) Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses. (Cost: High SP, Med Hunger)\",\"(Scavenge) Consume the remains of the Lesser Taratect to replenish essential proteins. (Cost: Low SP)\"]', '2026-04-06 04:04:57', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(29, 15, 'Launch a mid-air ambush on the distant spider cluster nearby, utilizing momentum to bypass their defenses.', '. Metabolic efficiency in the Elroe Labyrinth regions is currently skewed; environment temperature rising. SYSTEM ALERT: EXHAUSTION DETECTED. SPEED DEBUFF ACTIVE.]\n\nThe air in the upper reaches of Elroe is thick with the scent of stagnant humidity and mineral dust. Your leathery wings beat against the stale currents, your SPD attribute compensating for the creeping fatigue of the . \n\nYou initiate the dive. Gravity accelerates your descent, your body a blur of shadow against the jagged, limestone ceiling. The spider cluster below—tiny, skittering chitinous horrors—is unaware of the predatory arc until it is too late. You strike with the full force of your ATK, a concentrated impact against the center of the formation. The sound is a sickening *crack* of chitin failing under pressure. A spray of viscous, iridescent ichor coats your wings, momentarily blinding one of the targets as it spasms in its death throes. Your momentum carries you through the center of the cluster, scattering them like dry leaves, but your frame feels the strain; the impact sends a jolt of recoil through your meager DEF.\n\nYou hover, panting. The exertion of the maneuver, combined with the lingering debuff, burns through your already depleted reserves. You are a predator, but an exhausted one. The remaining spiders are turning, their multiple eyes glinting in the dark, sensing your vulnerability. \n\n\n\n\n\n---', '[\"(PREDATOR) Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism. (Cost: Med SP, Low Hunger)\",\"(Risky Action) Execute a localized aerial screech to disorient the cluster before diving into a head-on collision. (Cost: Low MP, High HP Risk)\",\"(Retreat) Use the remaining verticality of the cavern to climb out of sight and recover energy. (Cost: Low SP)\"]', '2026-04-06 04:21:10', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(30, 15, 'Dive back into the cluster to finish the wounded, prioritizing high-protein consumption to stabilize metabolism.', '*   **ENCOUNTER:** WILD Lvl 1 Elroe Frog (E) | HP: 55/55 | STATUS: ACTIVE.\n*   **THREAT LEVEL:** Moderate. Environmental hazard: Acidic secretions detected.\n*   **GLOBAL OBSERVERS:** The ceiling of the Labyrinth hums with unseen attention. Your struggle is being indexed for entertainment.\n*   **SYSTEM WARNING:** SP depletion reached critical threshold. Motor functions compromised. SPEED DEBUFF active.\n\n---\n\n### NARRATION\nThe air in the Elroe Labyrinth is thick with the scent of damp moss and stagnant subterranean water. You lunge, your wings twitching—a clumsy, desperate arc that betrays your lack of stamina. The Elroe Frog, a bloated mass of emerald sludge, tracks your movement with dull, pulsating eyes. \n\nYour SPD (18) is hampered by the 0/20 SP floor, turning your strike into a jagged, sluggish blur. You dive into the cluster, teeth bared, aiming for the soft, pulsating membrane beneath its jaw. The Frog reacts, its throat swelling, and sprays a globule of acidic venom. You jerk your head, the acidic mist searing the air inches from your ear—your RES (5) barely mitigating the localized heat. \n\nYour jaws clamp down, your ATK (7) tearing through the amphibian\'s thick, rubbery hide. It lets out a guttural, wet croak, thrashing against your weight. The metallic tang of ichor fills your mouth, but the kill is not yet confirmed. You are the predator, but the labyrinth is a cage, and you are starving. \n\n---\n\n\n\n\n\n---', '[\"Attack the Elroe Frog\",\"(Withdraw) Retreat to the upper ceiling to regain energy and observe the target\'s patterns. (Cost: Low SP)\",\"(PREDATOR) Maintain a death-grip on the throat and tear, prioritizing high-protein consumption to stabilize metabolism. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit. (Cost: High HP Risk)\"]', '2026-04-06 04:22:31', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(31, 15, 'Attempt to strike the Frog’s eyes to blind it, opening a path for a lethal critical hit.', 'The air in the Elroe Labyrinth is heavy with the scent of damp moss and the metallic tang of subterranean rot. Your wings twitch, hampered by the lethargy of a malnourished state. The Elroe Frog sits upon a slick, moss-covered crag, its throat sac pulsating with a rhythmic, wet sound. \n\nYou launch yourself, your SPD 18 allowing for a blur of movement through the cavern’s gloom. As you close the distance, the frog’s neck coils—a warning of impending acidic discharge. You compensate, your path erratic, and strike. Your talons rake across the creature’s moist, protuberant ocular organs. A viscous, caustic fluid sprays—green ichor splattering against the stone floor. The creature lets out a high-pitched, guttural croak of agony, reeling backward and thrashing its tongue in a blind, desperate arc. You have successfully blinded the target, but the strain of the rapid movement sends a jolt of fatigue through your undernourished wings.\n\n\n\nThe cavern wall is slick against your claws. The frog is disoriented, but its next strike will be a blind, wide-range acidic sweep. The metabolic demand is becoming critical; your body is beginning to cannibalize its own resources.\n\n\n\n\n***', '[\"(PREDATOR) Launch a follow-up pounce to secure the kill while the creature’s vision is compromised, aiming for the soft underbelly. (Cost: High SP, Med Hunger)\",\"Attack the Elroe Frog\",\"(Retreat) Use the remaining momentum to cling to the high cave wall and wait for the creature to exhaust itself. (Cost: Low SP)\",\"(Risky Action) Descend directly into the frog’s striking range to deliver a killing blow to the throat, risking exposure to acidic venom. (Cost: High HP Risk)\"]', '2026-04-06 04:23:53', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(32, 15, 'take a hit from the frog', 'The Elroe Labyrinth, Upper Stratum. Atmospheric conditions: Humid, stagnant air, smell of decay and damp limestone. Temperature: 22°C. \n\n\n---\n\nThe Shadow Bat descends into the muck, its wings folding tight. The Elroe Frog, a bloated, warty biological anomaly, senses the intrusion. Its throat sac expands, pulsating with a rhythmic, wet vibration. It doesn\'t wait; the creature snaps its jaw, releasing a globule of caustic venom.\n\nYou forgo evasion. The acid strikes your left wing membrane—a searing, localized thermal spike. Your RES attribute mitigates a portion of the chemical burn, but the acidic property bypasses your physical DEF of 4. The tissue sizzles, emitting a foul odor. Your SPD of 18 is severely compromised by the searing pain, dragging your flight capability into the red. The frog lets out a guttural croak, sensing your vulnerability as you reel from the chemical assault. Your HP is failing; every heartbeat sends a throbbing tremor through your damaged membrane.\n\n\n\n\n---', '[\"(PREDATOR) Launch a desperate aerial dive, ignoring the wing pain to clamp your fangs into the frog’s exposed throat sac. (Cost: High SP, Med Hunger)\",\"(Retreat) Flap your wings aggressively to create a cloud of cave dust and gain distance for a tactical withdrawal. (Cost: Low SP)\",\"(Risky Action) Remain stationary and attempt to use your remaining MAG to shield your body, hoping to bait the frog into a melee range error. (Cost: High HP Risk)\",\"Attack the Elroe Frog\"]', '2026-04-06 04:25:23', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(33, 15, 'Attack the Elroe Frog', '*Attention: Global update. Training cycles at the Royal Academy have resulted in the acquisition of  by external entities. Analysis suggests a shift in the hierarchy of power. Simultaneously, local biological anomaly  is currently engaged in high-risk combat within the Elroe Upper Strata.*\n\n---\n\n****\n\nThe cavern air is thick with the scent of damp moss and the stagnant humidity of the Elroe Upper Strata. Slick, condensation-slicked limestone presses in from all sides. \n\nYour instincts drive you forward, your SPD attribute allowing you to weave through the murky gloom with a flickering, unnatural grace. You lunge at the Elroe Frog, claws extended. Your ATK of 7 connects, tearing through the creature\'s rubbery, cyan-tinted hide. A viscous, neon-green ichor sprays across the cave floor, sizzling slightly where it hits the damp rock. The frog emits a pained, guttural croak that echoes painfully against the cavern walls.\n\nHowever, the exchange is not one-sided. Your SP is depleted—your movements are sluggish, betraying the exhaustion that grips your wings. The frog, despite its wounds, reacts with primitive fury. Its long, sticky tongue lashes out like a whip, catching you mid-maneuver. You are slammed against the jagged wall; the impact registers sharply against your DEF of 4. Your internal vitals pulse with the warning of sustained damage.\n\n**Current Status:**\n*   **HP:** 6/18\n*   **MP:** 15/15\n*   **Hunger:** 45/100\n*   **SP:** 0/20 (FATIGUE: SEVERE)\n\n---', '[\"Attack the Elroe Frog\",\"Attempt to Flee from the Elroe Frog\",\"(PREDATOR) Launch a desperate, all-or-nothing aerial strike at the frog\'s throat, aiming to finish the kill and consume the biomass. (Cost: High SP, Med Hunger)\",\"(Risky Action) Attempt to entangle the frog in a grapple, utilizing your proximity to force a struggle despite your current lack of stamina. (Cost: High HP Risk)\"]', '2026-04-06 04:30:37', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(34, 15, 'Attack the Elroe Frog', 'at the Academy, a biological anomaly struggles for base survival in the depths of Elroe_Upper.]\n\nThe cavern air is thick with the scent of stagnant moisture and volcanic sulfur. Your wings, translucent and fragile, beat sluggishly against the humid, oppressive atmosphere. You lunged with a burst of desperate speed, your talons carving into the Elroe Frog’s rubbery hide. The strike was clean, yet lacking the force to puncture the creature\'s thick dermis—a mere 4 DMG dealt. Green ichor welled from the shallow laceration, but the beast only shrieked, a wet, guttural sound that echoed off the slick cave walls.\n\nYour SP reserves are depleted. The exhaustion debuff is no longer a warning; it is a weight pulling at your membranes. \n\nAs you recoiled, the frog retaliated with terrifying, low-intelligence precision. A slimy, muscular limb whipped out, impacting your frail frame with blunt force. You were slammed against the jagged, damp rock face—3 HP lost. Your vision flickers. The cold, analytical truth is clear: you are losing the metabolic race.\n\n\n\n\n\n\n***\n\n\n\nThe hunt has concluded. You lacked the stamina to sustain the engagement, and your physical integrity fell below the threshold for continued operation. The Elroe Frog remains standing, its hunger overriding any fear of your species.', '[\"(Reincarnate) Accept the cycle of life and death, attempting a new manifestation in the Labyrinth. (Cost: Loss of current data)\",\"Attack the Elroe Frog\",\"(Escape) Utilize your remaining SPD to flee into the deeper, darker crevices of the cavern, abandoning the fight to survive. (Cost: Low SP)\",\"Attempt to Flee from the Elroe Frog\"]', '2026-04-06 04:39:13', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', NULL),
(35, 16, 'System Judgment Awakening', 'Processing… \nIdentity confirmed: Dwarf (Scavenger). \nAwakening sequence finalized in sector: iron_forge. \nThe System has cataloged your biological signature. You are now tethered to the local resource cycle. Proceed with caution.\n\n---\n\nThe air in the iron_forge is thick, tasting of oxidized iron and the sulfuric tang of cooling magma deep beneath the floor grates. The heat is a dry, oppressive blanket that clings to your dwarven beard, smelling faintly of coal dust and ancient, dormant industry. You stand in the center of a rusted, circular landing pad, the metal groaning under your boots—a sound that echoes far too loudly in the cavernous, soot-stained hall.\n\n\"Soul Scan Completed. Identity Confirmed.\"\n\nThe hum of the terminal fades into a discordant whine. Your internal diagnostics blink with clinical precision. Your SPD is currently uncalibrated, resulting in a lethargic, heavy-footed gait as you shift your weight. Your DEF is minimal, leaving your physical frame exposed to the abrasive, jagged edges of the surrounding scrap piles. As a scavenger, your sensory perception is currently hyper-focused on the rhythmic clicking of nearby machinery—sounds that dictate the flow of the forge’s ventilation.\n\nThe immediate pressure is mounting. Your biological frame is calibrated for heavy labor, yet your metabolic baseline is dwindling. The faint scent of stale oil and charred bone drifts from the dark corridors ahead. If you do not source sustenance or salvageable material soon, your internal vitals will cascade into a critical failure state.\n\n  \n\n---', '[\"(Investigate) Search the nearby rusted canisters for basic tools or rations. (Cost: Low SP)\",\"(SCAVENGER) Gut the derelict cooling unit for copper wiring and leftover lubricant. (Cost: High SP, Med Hunger)\",\"(Risky Action) Venture into the dark, active ventilation shaft where the heat is intense enough to cause burns. (Cost: High HP Risk)\"]', '2026-04-06 05:06:19', NULL, NULL);
INSERT INTO `action_logs` (`log_id`, `life_id`, `user_action`, `system_response`, `choices`, `created_at`, `bg_image`, `encounter_image`) VALUES
(36, 16, 'Venture into the dark, active ventilation shaft where the heat is intense enough to cause burn', '***\n\nThe heat within the iron_forge ventilation shaft is not merely warmth; it is a physical weight, a convective furnace designed to incinerate impurities. As you crawl into the narrow duct, the air carries the metallic tang of oxidized copper and scorched soot. Your thick, dwarven hide—optimized for subterranean environments—grants you a base resistance, but the extreme temperature pushes your thermal threshold to its limit. \n\nSweat evaporates from your pores before it can even bead, and the lack of moisture in the recycled, superheated air makes every breath feel like inhaling dry sand. You navigate the cramped, labyrinthine pipes with a sluggishness dictated by your low SPD, your movements hindered by the oppressive atmosphere. The intense heat causes your SP to drain rapidly as you fight the fatigue of thermal exhaustion. You are a biological anomaly surviving in an industrial kiln, but your core temperature is climbing toward critical levels.\n\n\n\n\n\nSurvival pressure: Your internal regulation is failing. Continued exposure to this thermal environment will result in heatstroke. You must either exit the ventilation shaft or find an intake coolant flow.', '[\"(SCAVENGER) Utilize your dwarven intuition to identify and pry open a concealed maintenance hatch, hoping to find a hidden cache of scavengeable coolant supplies. (Cost: High SP, Med Hunger)\",\"(Risky Action) Force yourself deeper into the core of the shaft to reach the primary exhaust vent, ignoring the increasing heat for a chance at finding salvage in the high-heat sector. (Cost: High HP Risk)\",\"(Approach) Carefully backtrack out of the shaft to return to the relative coolness of the forge floor. (Cost: Low SP)\"]', '2026-04-06 05:09:32', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `active_encounters`
--

CREATE TABLE `active_encounters` (
  `encounter_id` int(11) NOT NULL,
  `life_id` int(11) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `dynamic_level` int(11) DEFAULT 1,
  `current_hp` int(11) NOT NULL,
  `max_hp` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `active_encounters`
--

INSERT INTO `active_encounters` (`encounter_id`, `life_id`, `npc_id`, `dynamic_level`, `current_hp`, `max_hp`) VALUES
(1, 15, 2, 1, 47, 55);

-- --------------------------------------------------------

--
-- Table structure for table `current_life`
--

CREATE TABLE `current_life` (
  `life_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `vessel_type` varchar(100) DEFAULT 'Beast',
  `current_level` int(11) DEFAULT 1,
  `hp` int(11) DEFAULT 10,
  `max_hp` int(11) DEFAULT 10,
  `mp` int(11) DEFAULT 10,
  `max_mp` int(11) DEFAULT 10,
  `hunger` int(11) DEFAULT 100,
  `sp` int(11) DEFAULT 20,
  `max_sp` int(11) DEFAULT 20,
  `current_location` varchar(50) DEFAULT 'elroe_upper',
  `is_alive` tinyint(1) DEFAULT 1,
  `pos_x` int(11) DEFAULT 0,
  `pos_y` int(11) DEFAULT 0,
  `xp` int(11) DEFAULT 0,
  `next_level_xp` int(11) DEFAULT 100,
  `attribute_points` int(11) DEFAULT 0,
  `offense` int(11) DEFAULT 5,
  `defense` int(11) DEFAULT 5,
  `magic_power` int(11) DEFAULT 5,
  `resistance` int(11) DEFAULT 5,
  `speed` int(11) DEFAULT 5,
  `skill_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `current_life`
--

INSERT INTO `current_life` (`life_id`, `user_id`, `species`, `vessel_type`, `current_level`, `hp`, `max_hp`, `mp`, `max_mp`, `hunger`, `sp`, `max_sp`, `current_location`, `is_alive`, `pos_x`, `pos_y`, `xp`, `next_level_xp`, `attribute_points`, `offense`, `defense`, `magic_power`, `resistance`, `speed`, `skill_points`) VALUES
(9, 1, 'Cave Centipede', 'Beast', 1, 15, 15, 5, 5, 100, 20, 20, 'elroe_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0),
(10, 1, 'Small Lesser Taratect', 'Beast', 4, 15, 10, 6, 10, 100, 20, 20, 'elroe_upper', 1, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0),
(11, 2, 'Scrap Slime', 'Beast', 1, 14, 20, 20, 20, 100, 20, 20, 'elroe_upper', 0, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0),
(12, 2, 'Lesser Fire Wyrm', 'Beast', 1, 14, 25, 10, 10, 100, 20, 20, 'magma_layer', 1, 0, 0, 0, 100, 0, 5, 5, 5, 5, 5, 0),
(13, 3, 'Blind Cave Salamander', 'Beast', 1, 27, 30, 10, 10, 100, 20, 20, 'water_stratum', 0, 0, 0, 0, 100, 0, 6, 12, 4, 15, 5, 0),
(14, 3, 'Human', 'Predator', 1, 55, 55, 15, 15, 100, 35, 35, 'royal_capital', 0, 0, 0, 0, 100, 0, 12, 8, 5, 5, 5, 0),
(15, 3, 'Shadow Bat', 'Predator', 1, 0, 18, 15, 15, 33, 0, 20, 'elroe_upper', 0, 0, 0, 15, 100, 0, 7, 4, 5, 5, 18, 0),
(16, 3, 'Dwarf', 'Scavenger', 1, 80, 80, 10, 10, 100, 40, 45, 'iron_forge', 1, 0, 0, 0, 100, 0, 14, 20, 5, 5, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `duel_actions`
--

CREATE TABLE `duel_actions` (
  `action_id` int(11) NOT NULL,
  `duel_id` int(11) DEFAULT NULL,
  `actor_id` int(11) DEFAULT NULL,
  `action_text` text DEFAULT NULL,
  `system_description` text DEFAULT NULL,
  `choices` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`choices`)),
  `hp_after_action` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `duel_actions`
--

INSERT INTO `duel_actions` (`action_id`, `duel_id`, `actor_id`, `action_text`, `system_description`, `choices`, `hp_after_action`, `created_at`) VALUES
(2, 1, 1, 'ACCEPTED CHALLENGE', 'Location: elroe_upper\nMode: TO_POINT\n\nThe upper strata of the Great Elroe Labyrinth are bathed in a dim, bioluminescent glow, the air thick with the scent of damp moss and prehistoric dust. \n\nJoker, a Scrap Slime composed of rusted metal shards and viscous, translucent gel, quivers as it navigates the jagged stone floor. Its metallic core clinks rhythmically against the rock. Suddenly, the cavern floor trembles. From a crevice in the wall, Light—a Cave Centipede—erupts into the corridor. Its segmented chitinous plates shimmer like polished bone under the faint light, and its mandibles click with lethal precision, dripping with a paralyzing digestive enzyme. The centipede coils its massive, multi-legged body, sensing the metallic vibrations emanating from the slime. It locks its multifaceted eyes onto Joker, arching its thorax in preparation for a high-speed lunge.\n\nThe duel begins now.\n\n Use \"Rust Shrapnel\" to launch a cloud of jagged metal bits at the centipede’s sensory antennae to disorient it.]\n\n Retract into a dense, hardened metallic ball and bait the centipede into biting, hoping the sharp shards will lodge in its mandibles.]\n\n Utilize \"Gel-Slide\" to coat the cavern floor in slippery slime, forcing the multi-legged centipede to lose its footing during its charge.]', '[\"[Aggressive\",\"[Defensive\",\"[Evasive\"]', NULL, '2026-04-03 22:34:47'),
(3, 1, 2, 'Evasive', 'Mode: TO_POINT\nActor: joker (Scrap Slime) HP: 20\nTarget: light (Cave Centipede) HP: 15\n\n1. **Narration:**\nThe Scrap Slime collapses its amorphous, metallic frame into a shallow puddle, its jagged obsidian edges flattening against the cavern floor just as the Cave Centipede lunges. The centipede’s mandibles snap shut on empty, pressurized air, its serrated legs skittering harmlessly over the slime\'s shifting, viscous surface. The slime ripples, resetting its density and regaining its composure, having successfully bypassed the lethal strike.\n\n2. **HP Update:**\n (No damage dealt to target; Joker retains 20 HP)\n\n3. **Tactical Options:**', '[\"\\\"Corrosive Puddle\\\" - Joker liquifies further to coat the centipede’s underbelly, dealing 3 acid damage.\",\"\\\"Razor Spike\\\" - Joker hardens into a jagged turret and launches a projectile at the centipede’s weak point, dealing 5 damage.\",\"\\\"Binding Wrap\\\" - Joker lashes out with sticky, metallic pseudopods to restrain the centipede, preventing its next movement/action.\"]', NULL, '2026-04-03 22:39:11'),
(4, 1, 1, 'Binding Wrap', 'The Cave Centipede’s chitinous mandibles lock into position, erupting into a flurry of serrated limbs. The \"Binding Wrap\" maneuver initiates, coiling around the Scrap Slime\'s gelatinous, refuse-strewn mass. Thousands of microscopic hooks pierce the target\'s exterior, exerting constrictive pressure that forces pressurized fluids to rupture from the slime\'s porous hide. The structural integrity of the target sustains significant compromise.', '[\"Acidic Ejection (Release a caustic burst to force the centipede to disengage.)\",\"Recursive Absorption (Pull the centipede into the core mass to degrade its armored plating.)\",\"Dispersive Dash (Violently oscillate form to break the binding and relocate.)\"]', NULL, '2026-04-03 22:47:57');

-- --------------------------------------------------------

--
-- Table structure for table `duel_challenges`
--

CREATE TABLE `duel_challenges` (
  `duel_id` int(11) NOT NULL,
  `challenger_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `duel_type` enum('TO_POINT','TO_DEATH') DEFAULT 'TO_POINT',
  `status` enum('PENDING','ACCEPTED','REJECTED','COMPLETED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_action_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `duel_challenges`
--

INSERT INTO `duel_challenges` (`duel_id`, `challenger_id`, `target_id`, `duel_type`, `status`, `created_at`, `last_action_at`) VALUES
(1, 2, 1, 'TO_POINT', 'ACCEPTED', '2026-04-03 22:05:33', '2026-04-03 22:50:41');

-- --------------------------------------------------------

--
-- Table structure for table `evolution_paths`
--

CREATE TABLE `evolution_paths` (
  `evolution_id` int(11) NOT NULL,
  `from_species` varchar(100) DEFAULT NULL,
  `to_species` varchar(100) DEFAULT NULL,
  `req_level` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `evolution_paths`
--

INSERT INTO `evolution_paths` (`evolution_id`, `from_species`, `to_species`, `req_level`, `description`) VALUES
(1, 'Small Lesser Taratect', 'Small Taratect', 10, 'A balanced spider body with improved speed and thread production.'),
(2, 'Small Lesser Taratect', 'Small Poison Taratect', 10, 'Unlocks advanced Poison Synthesis but reduces physical defense.');

-- --------------------------------------------------------

--
-- Table structure for table `location_connectors`
--

CREATE TABLE `location_connectors` (
  `connector_id` int(11) NOT NULL,
  `from_location` varchar(50) NOT NULL,
  `to_location` varchar(50) NOT NULL,
  `direction` enum('UP','DOWN','NORTH','SOUTH','EAST','WEST','LEFT','RIGHT') NOT NULL,
  `min_level_req` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_connectors`
--

INSERT INTO `location_connectors` (`connector_id`, `from_location`, `to_location`, `direction`, `min_level_req`) VALUES
(1, 'elroe_upper', 'elroe_middle', 'DOWN', 1),
(2, 'elroe_middle', 'elroe_upper', 'UP', 1),
(3, 'elroe_middle', 'elroe_lower', 'DOWN', 1),
(4, 'elroe_lower', 'elroe_middle', 'UP', 1),
(5, 'elroe_lower', 'magma_layer', 'DOWN', 1),
(6, 'magma_layer', 'elroe_lower', 'UP', 1),
(7, 'magma_layer', 'ash_tunnels', 'DOWN', 1),
(8, 'ash_tunnels', 'magma_layer', 'UP', 1),
(9, 'elroe_upper', 'webbed_hollows', 'LEFT', 1),
(10, 'webbed_hollows', 'elroe_upper', 'RIGHT', 1),
(11, 'elroe_upper', 'fungus_grotto', 'RIGHT', 1),
(12, 'fungus_grotto', 'elroe_upper', 'LEFT', 1),
(13, 'elroe_lower', 'corpse_pit', 'LEFT', 1),
(14, 'corpse_pit', 'elroe_lower', 'RIGHT', 1),
(15, 'elroe_lower', 'dragon_breach', 'RIGHT', 1),
(16, 'dragon_breach', 'elroe_lower', 'LEFT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `location_seeds`
--

CREATE TABLE `location_seeds` (
  `location_id` varchar(50) NOT NULL,
  `description_seed` text DEFAULT NULL,
  `location_image` varchar(255) DEFAULT NULL,
  `danger_level` int(11) DEFAULT NULL,
  `region_name` varchar(50) DEFAULT 'elroe_labyrinth',
  `level_depth` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_seeds`
--

INSERT INTO `location_seeds` (`location_id`, `description_seed`, `location_image`, `danger_level`, `region_name`, `level_depth`) VALUES
('ash_tunnels', 'A suffocating network of tunnels filled with ash and smoke. Visibility is nearly zero, and breathing becomes a challenge. This is near-death territory.', 'http://localhost:7000/uploads/generic_1775338140044-109446823.png', 10, 'elroe_labyrinth', 4),
('corpse_pit', 'A feeding ground filled with rotting carcasses. Scavengers and predators gather here, creating constant conflict. The smell alone is overwhelming.', 'http://localhost:7000/uploads/generic_1775337601515-83449986.png', 8, 'elroe_labyrinth', 3),
('crystal_vein', 'A sharp, glowing cavern filled with crystal formations that hum with energy. Sound bends strangely here, and some creatures are drawn to its resonance.', 'http://localhost:7000/uploads/generic_1775337461034-28743475.png', 5, 'elroe_labyrinth', 2),
('dragon_breach', 'A broken cavern shaped by the movement of ancient dragons. Heat, pressure, and danger fill the air. This is not a place for the weak.', 'http://localhost:7000/uploads/generic_1775337760634-865578033.png', 9, 'elroe_labyrinth', 3),
('elroe_lower', 'Lower Elroe Labyrinth: A hellish, cavernous landscape teeming with earth dragons and venomous beasts.', 'http://localhost:7000/uploads/generic_1775337397083-148064841.png', 7, 'elroe_labyrinth', 2),
('elroe_middle', 'A transitional layer where tunnels widen and dangers increase. Echoes travel far, and predators roam between upper and lower layers. This is where survival becomes strategy.', 'http://localhost:7000/uploads/generic_1775336809832-102049221.png', 4, 'elroe_labyrinth', 1),
('elroe_upper', 'A sprawling network of dark, damp limestone caves. Weak monsters roam here, but survival is not guaranteed. Sticky webs line the ceilings, and the sound of distant movement never stops.', 'http://localhost:7000/uploads/generic_1775336009652-172069962.png', 2, 'elroe_labyrinth', 0),
('fungus_grotto', 'A humid cavern glowing with bioluminescent fungi. Spores drift through the air, feeding scavengers and poison-based creatures. Some fungi heal others kill.', 'http://localhost:7000/uploads/generic_1775336277019-933342202.png', 3, 'elroe_labyrinth', 1),
('magma_layer', 'Rivers of flowing lava cut through this region. The heat is unbearable, and only creatures adapted to extreme environments survive.', 'http://localhost:7000/uploads/generic_1775337971407-462015717.png', 9, 'elroe_labyrinth', 3),
('water_stratum', 'A flooded section of the labyrinth filled with underground streams and submerged tunnels. Visibility is low, and movement is slowed. Creatures here rely on vibration and sound.', 'http://localhost:7000/uploads/generic_1775337006193-800054934.png', 5, 'elroe_labyrinth', 2),
('webbed_hollows', 'A dense cluster of tunnels overtaken by spider colonies. Thick silk webs stretch across entire chambers, and egg sacs hang silently above. Movement is dangerous — and often noticed.', 'http://localhost:7000/uploads/generic_1775336056813-119887663.png', 3, 'elroe_labyrinth', 1);

-- --------------------------------------------------------

--
-- Table structure for table `master_npcs`
--

CREATE TABLE `master_npcs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `species_type` varchar(50) DEFAULT NULL,
  `base_hp` int(11) DEFAULT NULL,
  `base_level` int(11) DEFAULT NULL,
  `danger_rank` varchar(20) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `npc_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `master_npcs`
--

INSERT INTO `master_npcs` (`id`, `name`, `species_type`, `base_hp`, `base_level`, `danger_rank`, `description`, `npc_image`) VALUES
(1, 'Small Lesser Taratect', 'MONSTER', 20, 1, 'F', 'A weak spider hatchling.', NULL),
(2, 'Elroe Frog', 'BEAST', 45, 3, 'E', 'Spits acidic venom.', NULL),
(3, 'Anogatch', 'MONSTER', 120, 10, 'B', 'A huge monkey-like creature that hunts in packs.', NULL),
(4, 'Earth Dragon Araba', 'DRAGON', 8000, 35, 'S', 'The apex predator of the Lower Stratum.', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `reincarnated_npcs`
--

CREATE TABLE `reincarnated_npcs` (
  `npc_id` int(11) NOT NULL,
  `original_name` varchar(50) DEFAULT NULL,
  `new_name` varchar(50) DEFAULT NULL,
  `current_species` varchar(50) DEFAULT NULL,
  `current_location` varchar(50) DEFAULT NULL,
  `status_log` text DEFAULT NULL,
  `is_player_event` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reincarnated_npcs`
--

INSERT INTO `reincarnated_npcs` (`npc_id`, `original_name`, `new_name`, `current_species`, `current_location`, `status_log`, `is_player_event`) VALUES
(1, 'Shun', 'Schlain', 'Human (Hero Title)', 'royal_capital', 'Training at the Royal Academy. Acquired [Divine Magic].', 1),
(2, 'Shinohara', 'Feirune', 'Earth Dragon', 'elroe_upper', 'Wandering the upper labyrinth looking for food.', 1),
(3, 'Wakaba', 'D', 'Unknown', 'unknown', 'Watching the labyrinth with amusement.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `relationships`
--

CREATE TABLE `relationships` (
  `rel_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `target_id` int(11) DEFAULT NULL,
  `bond_type` enum('FRIEND','RIVAL') NOT NULL,
  `status` enum('PENDING','ACCEPTED') DEFAULT 'PENDING',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `relationships`
--

INSERT INTO `relationships` (`rel_id`, `user_id`, `target_id`, `bond_type`, `status`, `created_at`) VALUES
(1, 1, 2, 'FRIEND', 'ACCEPTED', '2026-04-03 20:49:33'),
(2, 2, 1, 'FRIEND', 'ACCEPTED', '2026-04-03 20:59:50');

-- --------------------------------------------------------

--
-- Table structure for table `soul_library`
--

CREATE TABLE `soul_library` (
  `user_id` int(11) NOT NULL,
  `soul_rank` int(11) DEFAULT 1,
  `accumulated_karma` int(11) DEFAULT 0,
  `permanent_skills` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permanent_skills`)),
  `death_count` int(11) DEFAULT 0,
  `skill_points` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soul_library`
--

INSERT INTO `soul_library` (`user_id`, `soul_rank`, `accumulated_karma`, `permanent_skills`, `death_count`, `skill_points`) VALUES
(1, 1, 0, '[\"Night Vision\",\"Thread Manipulation\",\"Camouflage\",\"Thread Craft\"]', 0, 0),
(2, 1, 0, '[]', 0, 0),
(3, 1, 0, '[]', 0, 0),
(4, 1, 0, '[]', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `starting_vessels`
--

CREATE TABLE `starting_vessels` (
  `vessel_id` int(11) NOT NULL,
  `soul_path` varchar(50) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `base_hp` int(11) DEFAULT NULL,
  `base_mp` int(11) DEFAULT NULL,
  `starting_location` varchar(50) DEFAULT NULL,
  `vessel_image` varchar(255) DEFAULT NULL,
  `base_offense` int(11) DEFAULT 5,
  `base_defense` int(11) DEFAULT 5,
  `base_magic_power` int(11) DEFAULT 5,
  `base_resistance` int(11) DEFAULT 5,
  `base_speed` int(11) DEFAULT 5,
  `base_hunger` int(11) DEFAULT 100,
  `base_sp` int(11) DEFAULT 20
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `starting_vessels`
--

INSERT INTO `starting_vessels` (`vessel_id`, `soul_path`, `species`, `base_hp`, `base_mp`, `starting_location`, `vessel_image`, `base_offense`, `base_defense`, `base_magic_power`, `base_resistance`, `base_speed`, `base_hunger`, `base_sp`) VALUES
(1, 'Scavenger', 'Small Lesser Taratect', 10, 10, 'elroe_upper', NULL, 6, 4, 8, 5, 12, 100, 20),
(2, 'Scavenger', 'Cave Centipede', 15, 5, 'elroe_upper', NULL, 8, 6, 2, 4, 10, 100, 20),
(3, 'Scavenger', 'Scrap Slime', 20, 20, 'elroe_upper', NULL, 4, 10, 12, 12, 3, 100, 20),
(4, 'Scavenger', 'Spectral Mite', 8, 25, 'elroe_upper', NULL, 3, 2, 15, 10, 14, 100, 20),
(5, 'Predator', 'Wolf Pup', 20, 5, 'elroe_upper', NULL, 12, 6, 2, 4, 15, 100, 20),
(6, 'Predator', 'Lesser Fire Wyrm', 25, 10, 'magma_layer', NULL, 14, 8, 10, 8, 10, 100, 20),
(7, 'Predator', 'Venomous Hatchling', 22, 12, 'elroe_lower', NULL, 11, 5, 6, 5, 13, 100, 20),
(8, 'Predator', 'Shadow Bat', 18, 15, 'elroe_upper', NULL, 7, 4, 9, 6, 18, 100, 20),
(9, 'Prey', 'Weakling Rat', 5, 5, 'elroe_upper', NULL, 3, 2, 1, 2, 8, 100, 20),
(10, 'Prey', 'Crystalline Snail', 40, 30, 'magma_layer', NULL, 5, 25, 10, 20, 1, 100, 20),
(11, 'Prey', 'Cave Bat', 8, 8, 'elroe_upper', NULL, 4, 3, 5, 4, 12, 100, 20),
(12, 'Prey', 'Blind Cave Salamander', 30, 10, 'water_stratum', NULL, 6, 12, 4, 15, 5, 100, 20),
(13, 'Predator', 'Human', 55, 15, 'royal_capital', NULL, 12, 8, 5, 5, 5, 100, 35),
(14, 'Prey', 'Human', 45, 30, 'royal_capital', NULL, 6, 12, 5, 5, 5, 100, 25),
(15, 'Scavenger', 'Dwarf', 80, 10, 'iron_forge', NULL, 14, 20, 5, 5, 5, 120, 45);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(20) DEFAULT 'player',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `system_voice` varchar(20) DEFAULT 'ADMIN'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password_hash`, `role`, `created_at`, `system_voice`) VALUES
(1, '8amlight@gmail.com', 'light', '$2b$10$XYlXKzvMUZnO.hYgvGPd8.K/PyBsEkJxR2TxGa3ykjWKPsEeNyQ4G', 'player', '2026-04-03 18:11:06', 'ADMIN'),
(2, '8amjoker@gmail.com', 'joker', '$2b$10$KdHV2FZUFHeVTBn.F202Gu5UvetTetwIqXSdJVLV5lUXBMYgK95yW', 'player', '2026-04-03 20:38:39', 'ADMIN'),
(3, 'admin@admin.com', 'god', '$2b$10$yzahJBWCcGAa76.lFLzvsOquEc3nvk8j/6fw8oWBt5Iq9IVGugExq', 'admin', '2026-04-03 23:13:02', 'ADMIN'),
(4, 'oghenesupersam914@gmail.com', 'sam', '$2b$10$qSORTKmr2y/Fst3sskTeZul1G.bscCXuiEoAUJooCZrqVWSp.yJyy', 'player', '2026-04-04 01:42:30', 'ADMIN');

-- --------------------------------------------------------

--
-- Table structure for table `zone_spawns`
--

CREATE TABLE `zone_spawns` (
  `spawn_id` int(11) NOT NULL,
  `zone_name` varchar(50) NOT NULL,
  `npc_id` int(11) NOT NULL,
  `spawn_chance` int(11) DEFAULT 30
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `zone_spawns`
--

INSERT INTO `zone_spawns` (`spawn_id`, `zone_name`, `npc_id`, `spawn_chance`) VALUES
(1, 'elroe_upper', 1, 40),
(2, 'elroe_upper', 2, 25),
(3, 'elroe_upper', 3, 10),
(4, 'magma_layer', 4, 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `life_id` (`life_id`);

--
-- Indexes for table `active_encounters`
--
ALTER TABLE `active_encounters`
  ADD PRIMARY KEY (`encounter_id`),
  ADD KEY `life_id` (`life_id`),
  ADD KEY `npc_id` (`npc_id`);

--
-- Indexes for table `current_life`
--
ALTER TABLE `current_life`
  ADD PRIMARY KEY (`life_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `duel_actions`
--
ALTER TABLE `duel_actions`
  ADD PRIMARY KEY (`action_id`),
  ADD KEY `duel_id` (`duel_id`);

--
-- Indexes for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  ADD PRIMARY KEY (`duel_id`),
  ADD KEY `challenger_id` (`challenger_id`),
  ADD KEY `target_id` (`target_id`);

--
-- Indexes for table `evolution_paths`
--
ALTER TABLE `evolution_paths`
  ADD PRIMARY KEY (`evolution_id`);

--
-- Indexes for table `location_connectors`
--
ALTER TABLE `location_connectors`
  ADD PRIMARY KEY (`connector_id`);

--
-- Indexes for table `location_seeds`
--
ALTER TABLE `location_seeds`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `master_npcs`
--
ALTER TABLE `master_npcs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reincarnated_npcs`
--
ALTER TABLE `reincarnated_npcs`
  ADD PRIMARY KEY (`npc_id`);

--
-- Indexes for table `relationships`
--
ALTER TABLE `relationships`
  ADD PRIMARY KEY (`rel_id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`target_id`),
  ADD KEY `target_id` (`target_id`);

--
-- Indexes for table `soul_library`
--
ALTER TABLE `soul_library`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `starting_vessels`
--
ALTER TABLE `starting_vessels`
  ADD PRIMARY KEY (`vessel_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  ADD PRIMARY KEY (`spawn_id`),
  ADD KEY `npc_id` (`npc_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `active_encounters`
--
ALTER TABLE `active_encounters`
  MODIFY `encounter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `current_life`
--
ALTER TABLE `current_life`
  MODIFY `life_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `duel_actions`
--
ALTER TABLE `duel_actions`
  MODIFY `action_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  MODIFY `duel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `evolution_paths`
--
ALTER TABLE `evolution_paths`
  MODIFY `evolution_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `location_connectors`
--
ALTER TABLE `location_connectors`
  MODIFY `connector_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `master_npcs`
--
ALTER TABLE `master_npcs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `reincarnated_npcs`
--
ALTER TABLE `reincarnated_npcs`
  MODIFY `npc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `relationships`
--
ALTER TABLE `relationships`
  MODIFY `rel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `starting_vessels`
--
ALTER TABLE `starting_vessels`
  MODIFY `vessel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  MODIFY `spawn_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD CONSTRAINT `action_logs_ibfk_1` FOREIGN KEY (`life_id`) REFERENCES `current_life` (`life_id`) ON DELETE CASCADE;

--
-- Constraints for table `active_encounters`
--
ALTER TABLE `active_encounters`
  ADD CONSTRAINT `active_encounters_ibfk_1` FOREIGN KEY (`life_id`) REFERENCES `current_life` (`life_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `active_encounters_ibfk_2` FOREIGN KEY (`npc_id`) REFERENCES `master_npcs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `current_life`
--
ALTER TABLE `current_life`
  ADD CONSTRAINT `current_life_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `soul_library` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `duel_actions`
--
ALTER TABLE `duel_actions`
  ADD CONSTRAINT `duel_actions_ibfk_1` FOREIGN KEY (`duel_id`) REFERENCES `duel_challenges` (`duel_id`) ON DELETE CASCADE;

--
-- Constraints for table `duel_challenges`
--
ALTER TABLE `duel_challenges`
  ADD CONSTRAINT `duel_challenges_ibfk_1` FOREIGN KEY (`challenger_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `duel_challenges_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `relationships`
--
ALTER TABLE `relationships`
  ADD CONSTRAINT `relationships_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `relationships_ibfk_2` FOREIGN KEY (`target_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `soul_library`
--
ALTER TABLE `soul_library`
  ADD CONSTRAINT `soul_library_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `zone_spawns`
--
ALTER TABLE `zone_spawns`
  ADD CONSTRAINT `zone_spawns_ibfk_1` FOREIGN KEY (`npc_id`) REFERENCES `master_npcs` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
