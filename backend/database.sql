-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 04, 2026 at 04:08 PM
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
(8, 12, 'System Awakening', '[SYSTEM INITIALIZATION: COMPLETE]\n[SUBJECT STATUS: AWAKENED]\n[BIOLOGICAL CLASSIFICATION: LESSER FIRE WYRM (JUVENILE)]\n[LOCATION: MAGMA_LAYER_SECTOR_04]\n[ENVIRONMENTAL HAZARD: EXTREME THERMAL DENSITY DETECTED]\n\n[ERROR: NEURAL MAPPING INCOMPLETE]\n[WARNING: INSTINCTUAL OVERRIDE DETECTED]\n[LOG: CONSCIOUSNESS DETECTED WITHIN ORGANIC VESSEL. MOTOR FUNCTIONS RESPONDING TO PREDATORY PRIMAL DRIVES. ANALYTICAL PROCESSING IS CURRENTLY INTERFERING WITH BIOLOGICAL IMPULSES.]\n\nYou are curled within a cradle of cooling basalt and liquid rock. Your scales—obsidian-black and searing to the touch—clatter against the stone as you shift. The air tastes of sulfur and raw kinetic energy. Your vision is split: one input registers the physical world through heat-vision, flickering in shades of blinding white and deep violet; the other input is a scrolling, sterile stream of data reporting your own hunger, your internal temperature, and the proximity of potential biomass. \n\nA primal roar bubbles in your throat, but it is accompanied by a text-prompt in your mind. The system demands an immediate calibration of your predatory instincts.\n\n**CHOOSE YOUR PRIMARY EVOLUTIONARY FOCUS:**\n\n**[A] CONSUME THE CRUST:** Direct all sensory input toward the magma flow. Digest the surrounding rock and thermal energy to rapidly expand your physical frame. *Trade-off: High growth potential, low immediate mobility.*\n\n**[B] SEEK THE VIBRATION:** Ignore the hunger and focus on the tremors in the distance. Hunt for the entity producing rhythmic vibrations in the rock. *Trade-off: High lethality/tactical experience, risk of environmental exposure.*\n\n**[C] RECALIBRATE INSTINCTS:** Attempt to bypass the mechanical interface and synchronize your soul with the Wyrm’s biological mind. *Trade-off: Slow initialization, potential to stabilize the mental dissonance and unlock hidden draconic capabilities.*', NULL, '2026-04-03 20:40:30', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `current_life`
--

CREATE TABLE `current_life` (
  `life_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `species` varchar(100) DEFAULT NULL,
  `current_level` int(11) DEFAULT 1,
  `hp` int(11) DEFAULT 10,
  `max_hp` int(11) DEFAULT 10,
  `mp` int(11) DEFAULT 10,
  `max_mp` int(11) DEFAULT 10,
  `current_location` varchar(50) DEFAULT 'elroe_upper',
  `is_alive` tinyint(1) DEFAULT 1,
  `pos_x` int(11) DEFAULT 0,
  `pos_y` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `current_life`
--

INSERT INTO `current_life` (`life_id`, `user_id`, `species`, `current_level`, `hp`, `max_hp`, `mp`, `max_mp`, `current_location`, `is_alive`, `pos_x`, `pos_y`) VALUES
(9, 1, 'Cave Centipede', 1, 15, 15, 5, 5, 'elroe_upper', 0, 0, 0),
(10, 1, 'Small Lesser Taratect', 4, 15, 10, 6, 10, 'elroe_upper', 1, 0, 0),
(11, 2, 'Scrap Slime', 1, 14, 20, 20, 20, 'elroe_upper', 0, 0, 0),
(12, 2, 'Lesser Fire Wyrm', 1, 14, 25, 10, 10, 'magma_layer', 1, 0, 0);

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
-- Table structure for table `location_seeds`
--

CREATE TABLE `location_seeds` (
  `location_id` varchar(50) NOT NULL,
  `description_seed` text DEFAULT NULL,
  `location_image` varchar(255) DEFAULT NULL,
  `danger_level` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `location_seeds`
--

INSERT INTO `location_seeds` (`location_id`, `description_seed`, `location_image`, `danger_level`) VALUES
('elroe_lower', 'Lower Elroe Labyrinth: A hellish, cavernous landscape teeming with earth dragons and venomous beasts.', NULL, 6),
('elroe_upper', 'Upper Elroe Labyrinth: A sprawling network of dark, damp limestone caves. Weak monsters and sticky webs everywhere.', NULL, 2),
('magma_layer', 'Magma Layer: Rivers of flowing lava and extreme heat. Fire resistance is mandatory.', NULL, 9);

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
  `death_count` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soul_library`
--

INSERT INTO `soul_library` (`user_id`, `soul_rank`, `accumulated_karma`, `permanent_skills`, `death_count`) VALUES
(1, 1, 0, '[\"Night Vision\",\"Thread Manipulation\",\"Camouflage\",\"Thread Craft\"]', 0),
(2, 1, 0, '[]', 0),
(3, 1, 0, '[]', 0),
(4, 1, 0, '[]', 0);

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
  `vessel_image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `starting_vessels`
--

INSERT INTO `starting_vessels` (`vessel_id`, `soul_path`, `species`, `base_hp`, `base_mp`, `starting_location`, `vessel_image`) VALUES
(1, 'Scavenger', 'Small Lesser Taratect', 10, 10, 'elroe_upper', NULL),
(2, 'Scavenger', 'Cave Centipede', 15, 5, 'elroe_upper', NULL),
(3, 'Scavenger', 'Scrap Slime', 20, 20, 'elroe_upper', NULL),
(4, 'Predator', 'Wolf Pup', 20, 5, 'elroe_upper', NULL),
(5, 'Predator', 'Lesser Fire Wyrm', 25, 10, 'magma_layer', NULL),
(6, 'Prey', 'Weakling Rat', 5, 5, 'elroe_upper', NULL),
(7, 'Prey', 'Cave Bat', 8, 8, 'elroe_upper', NULL);

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
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password_hash`, `role`, `created_at`) VALUES
(1, '8amlight@gmail.com', 'light', '$2b$10$XYlXKzvMUZnO.hYgvGPd8.K/PyBsEkJxR2TxGa3ykjWKPsEeNyQ4G', 'player', '2026-04-03 18:11:06'),
(2, '8amjoker@gmail.com', 'joker', '$2b$10$KdHV2FZUFHeVTBn.F202Gu5UvetTetwIqXSdJVLV5lUXBMYgK95yW', 'player', '2026-04-03 20:38:39'),
(3, 'admin@admin.com', 'god', '$2b$10$yzahJBWCcGAa76.lFLzvsOquEc3nvk8j/6fw8oWBt5Iq9IVGugExq', 'admin', '2026-04-03 23:13:02'),
(4, 'oghenesupersam914@gmail.com', 'sam', '$2b$10$qSORTKmr2y/Fst3sskTeZul1G.bscCXuiEoAUJooCZrqVWSp.yJyy', 'player', '2026-04-04 01:42:30');

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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `action_logs`
--
ALTER TABLE `action_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `current_life`
--
ALTER TABLE `current_life`
  MODIFY `life_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
  MODIFY `vessel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `action_logs`
--
ALTER TABLE `action_logs`
  ADD CONSTRAINT `action_logs_ibfk_1` FOREIGN KEY (`life_id`) REFERENCES `current_life` (`life_id`) ON DELETE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
