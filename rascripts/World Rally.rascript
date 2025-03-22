// World Rally
// #ID = 27016

// Difficulty mode (core settings) functions
// -----------------------------------------

// Difficulty mode easy (core settings)
function isEasyDifficulty() {
    return byte(0x000108) == 123 &&  byte(0x002BDE) == 0
}

// Difficulty mode normal (core settings)
function isNormalDifficulty() {
    return byte(0x000108) == 251 &&  byte(0x002BDE) == 20
}

// Difficulty mode hard (core settings)
function isHardDifficulty() {
    return byte(0x000108) == 187 &&  byte(0x002BDE) == 40
}

// Difficulty mode hardest (core settings)
function isHardestDifficulty() {
    return byte(0x000108) == 59 &&  byte(0x002BDE) == 60
}

// Difficulty mode normal or higher (core settings)
function isNormalOrHigherDifficulty() {
    return isNormalDifficulty() || isHardDifficulty() || isHardestDifficulty()
}


// Rally selection functions
// -------------------------

// Rally San Remo has been selected (any moment)
function isRallySanRemoSelected(){
    return byte(0x003370) == 1
}

// Rally Monte-Carlo has been selected (any moment)
function isRallyMonteCarloSelected(){
    return byte(0x003372) == 1
}

// Rally Monte-Carlo has been selected (any moment)
function isRallyAcropolisSelected(){
    return byte(0x003374) == 1
}

// Rally of the 1000 Lakes has been selected (any moment)
function isRally1000LakesSelected(){
    return byte(0x003376) == 1
}

// Rally playing functions
// -----------------------

// Get the current Rally playing
function getCurrentRally() => byte(0x003378)

// Is Rally San Remo the current rally playing?
function isPlayingRallySanRemo() {
    return getCurrentRally() == 0
}

// Is Rally Monte-Carlo the current rally playing?
function isPlayingRallyMonteCarlo() {
    return getCurrentRally() == 1
}

// Is Rally Acropolis the current rally playing?
function isPlayingRallyAcropolis() {
    return getCurrentRally() == 2
}

// Is Rally San Remo the current rally playing?
function isPlayingRally1000Lakes() {
    return getCurrentRally() == 3
}

// Get current stage
function getCurrentStage() => byte(0x00337A)

// Rally position functions
// ------------------------
function getStagePosition() => byte(0x00345C)

function getRallyPosition() => byte(0x003462)

function getWorldChampionshipPosition() => byte(0x003472)


// Rally points (Initial value 0xFF) functions
// -------------------------------------------

// Get Rally San Remo points
function getRallySanRemoPoints() => byte(0x0032EC)

// Get Rally Monte-Carlo points
function getRallyMonteCarloPoints() => byte(0x0032EE)

// Get Rally Acropolis points
function getRallyAcropolisPoints() => byte(0x0032F0)

// Get Rally of the 1000 Lakes points
function getRally1000LakesPoints() => byte(0x0032F2)

// Get World Championship points
function getWorldChampionshipPoints() => byte(0x00346C)



// Get the number of rallies completed
function getTotalRalliesCompleted() => byte(0x00349a)


// Game metadata functions
// -----------------------
// Get how many extra credits have been used
function getExtraCreditsUsed() => byte(0x003538)

// One player mode and only one "active"
function isOnePlayerMode() {
    return byte(0x00354E) == 1 && byte(0x0033AC) == 1
}


// 0x00 = No credit is inserted yet
// 0x10 (16) = In the player selection screen, when you have more than 1 credit (not at the very start of the game/rom)
// 0x52 (82) = In the player selection screen, when you have only 1 credit
// 0x72 (114) = When the game finish (win or lose)

// These values stay until new credits inserted

// Check if your game is finished (win or lose) or no started (no credits insert)
function isGameFinished() {
    return byte(0x003552) == 0 || byte(0x003552) == 114
}


// Get current total score points 
function getScorePoints() {
    return (word(0x0001ca) * 65536) + word(0x0001cc)
}

// Get Chrono value during the stage
    // 472 = 47.2
    // At the end of the stage go to 0
function getChronoTime() => word(0x003F08)

// 0x00 to 0x05, change every frame
function getChronoFrame() => byte(0x003f06)

// Function to convert to hundreths of seconds relatively real (6 frames in 10 hundreths of seconds)
function convertChronoFrameToTime(previousFrame){
    if(previousFrame){
        return (prev(getChronoFrame()) * 10) / 6  
    }
    else{
        return (getChronoFrame() * 3) / 2            
    }
}


// Custom functions
function stageCleared() {
    return repeated(400, getChronoTime() > prev(getChronoTime())) && 
           getChronoTime() == 0 &&
           never(repeated(10, getChronoTime() > 600))
}

function getCentisecStageTime(){
    return (prev(getChronoTime()) * 10) + convertChronoFrameToTime(previousFrame = true)
}

/*
function getMilisecStageTime(){
    return ((byte(0x003282) - 48) * 10) + // Thenths of second (ASCII)
           ((byte(0x003280) - 48) * 100) + // Last digit of the seconds (ASCII)
           ((byte(0x003281) - 48) * 1000) // First digit of the seconds (ASCII)
}
*/

// Variables

rally_sanremo_stages = {
    0: {
        "idAchievement": 506655,
        "idLeaderboard": 127072,
        "name" : "Peranaldo",
        "stage": 1,
        "winningTitle": "Miki Biasion",
        "winningPoints" : 1,
    },
    1: {
        "idAchievement": 506656,
        "idLeaderboard": 127073,    
        "name" : "Totip",
        "stage": 2,
        "winningTitle": "Giandomenico Basso",
        "winningPoints" : 3,
    },
    2: {
        "idAchievement": 506657,    
        "idLeaderboard": 127097, 
        "name" : "Ospedaletti",
        "stage": 3,
        "winningTitle": "Paolo Andreucci",
        "winningPoints" : 5,
    }
}

rally_montecarlo_stages = {
    0: {
        "idAchievement": 507060,
        "idLeaderboard": 127098,
        "name" : "Moulinon",
        "stage": 1,
        "winningTitle": "Didier Auriol",
        "winningPoints" : 2,
    },
    1: {
        "idAchievement": 507061,
        "idLeaderboard": 127099,    
        "name" : "Sisteron",
        "stage": 2,
        "winningTitle": "Sebastian Ogier",
        "winningPoints" : 3,
    },
    2: {
        "idAchievement": 507062,    
        "idLeaderboard": 127100, 
        "name" : "Col de Turini",
        "stage": 3,
        "winningTitle": "Sebastian Loeb",
        "winningPoints" : 5,
    }
}

rally_acropolis_stages = {
    0: {
        "idAchievement": 0,
        "idLeaderboard": 127101,
        "name" : "Tarzan",
        "stage": 1,
        "winningTitle": "George Moschous",
        "winningPoints" : 2,
    },
    1: {
        "idAchievement": 0,
        "idLeaderboard": 127102,    
        "name" : "Vari",
        "stage": 2,
        "winningTitle": "Anastasios Markouizos",
        "winningPoints" : 3,
    },
    2: {
        "idAchievement": 0,    
        "idLeaderboard": 127103, 
        "name" : "Kinetta",
        "stage": 3,
        "winningTitle": "Tassos Livieratos",
        "winningPoints" : 5,
    }
}

rally_1000lakes_stages = {
    0: {
        "idAchievement": 0,
        "idLeaderboard": 127104,
        "name" : "Myhipaa",
        "stage": 1,
        "winningTitle": "Marcus Gronholm",
        "winningPoints" : 2,
    },
    1: {
        "idAchievement": 0,
        "idLeaderboard": 127105,    
        "name" : "Konivuori",
        "stage": 2,
        "winningTitle": "Juha Kankkunen",
        "winningPoints" : 3,
    },
    2: {
        "idAchievement": 0,    
        "idLeaderboard": 127106, 
        "name" : "Laajavuori",
        "stage": 3,
        "winningTitle": "Tommi Makinen",
        "winningPoints" : 5,
    }
}

// TODO: Hacer lo mismo con el resto de rallies


// Achievements - Stages
// ---------------------

achievement(
    title = "Fast and Furious", points = 1, type="missable",
    description = "Win a rally stage [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              stageCleared() &&
              getStagePosition() == 0
)

for st in rally_sanremo_stages {
    achievement(
        id = rally_sanremo_stages[st]["idAchievement"],
        title = rally_sanremo_stages[st]["winningTitle"], points = rally_sanremo_stages[st]["winningPoints"], type="missable",
        description = format("Win {0} Stage - Rally SanRemo Stage {1} [1p mode]", 
            rally_sanremo_stages[st]["name"], rally_sanremo_stages[st]["stage"]),
        trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  isRallySanRemoSelected() && isPlayingRallySanRemo() &&
                  getCurrentStage() == st &&
                  stageCleared() &&
                  getStagePosition() == 0
    )    
}

for st in rally_montecarlo_stages {
    achievement(
        id = rally_montecarlo_stages[st]["idAchievement"],    
        title = rally_montecarlo_stages[st]["winningTitle"], points = rally_montecarlo_stages[st]["winningPoints"], type="missable",
        description = format("Win {0} Stage - Rally Monte-Carlo Stage {1} [1p mode]", 
            rally_montecarlo_stages[st]["name"], rally_montecarlo_stages[st]["stage"]),
        trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo() &&
                  getCurrentStage() == st &&
                  stageCleared() &&
                  getStagePosition() == 0
    )    
}

for st in rally_acropolis_stages {
    achievement(
        id = rally_acropolis_stages[st]["idAchievement"],    
        title = rally_acropolis_stages[st]["winningTitle"], points = rally_acropolis_stages[st]["winningPoints"], type="missable",
        description = format("Win {0} Stage - Rally Acropolis Stage {1} [1p mode]", 
            rally_acropolis_stages[st]["name"], rally_acropolis_stages[st]["stage"]),
        trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  isRallyAcropolisSelected() && isPlayingRallyAcropolis() &&
                  getCurrentStage() == st &&
                  stageCleared() &&
                  getStagePosition() == 0
    )    
}

for st in rally_1000lakes_stages {
    achievement(
        id = rally_1000lakes_stages[st]["idAchievement"],    
        title = rally_1000lakes_stages[st]["winningTitle"], points = rally_1000lakes_stages[st]["winningPoints"], type="missable",
        description = format("Win {0} Stage - Rally of the 1000 Lakes Stage {1} [1p mode]", 
            rally_1000lakes_stages[st]["name"], rally_1000lakes_stages[st]["stage"]),
        trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  isRally1000LakesSelected() && isPlayingRally1000Lakes() &&
                  getCurrentStage() == st &&
                  stageCleared() &&
                  getStagePosition() == 0
    )    
}



// Achievements - Rallies Completed
// --------------------------------

achievement(
    id = 0,
    title = "Arrivederci San Remo", points = 5, type="progression",
    description = "Complete Rally San Remo, Italy [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && getRallySanRemoPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 0,
    title = "A walk along the Cote dAzur", points = 5, type="progression",
    description = "Complete Rally MonteCarlo, France [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyMonteCarloSelected() && getRallyMonteCarloPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 0,
    title = "Olympic Games", points = 5, type="progression",
    description = "Complete Rally Acropolis, Greece [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyAcropolisSelected() && getRallyAcropolisPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 0,
    title = "Let it go, Let it go...", points = 5, type="progression",
    description = "Complete Rally of the 1000 Lakes, Finland [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRally1000LakesSelected() && getRally1000LakesPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() > 0
)

// Achievements - Rallies Won
// --------------------------

achievement(
    id = 506658,
    title = "Gladiator", points = 10, type="missable",
    description = "Win Rally San Remo, Italy [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && getRallySanRemoPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 507060,
    title = "Casino Royale", points = 10, type="missable",
    description = "Win Rally MonteCarlo, France [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyMonteCarloSelected() && getRallyMonteCarloPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 0,
    title = "Greek God", points = 10, type="missable",
    description = "Win Rally Acropolis, Greece [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyAcropolisSelected() && getRallyAcropolisPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    id = 0,
    title = "King in the North", points = 10, type="missable",
    description = "Win Rally 1000 Lakes, Finland [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRally1000LakesSelected() && getRally1000LakesPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

// Achievements - Game Completed
// -----------------------------

achievement(
    id = 0,
    title = "The job is done", points = 25, type="win_condition",
    description = "Complete the game [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && isRallyMonteCarloSelected() && isRallyAcropolisSelected() && isRally1000LakesSelected() &&
              getRallySanRemoPoints() != 0xFF && getRallyMonteCarloPoints() != 0xFF && getRallyAcropolisPoints() != 0xFF && getRally1000LakesPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() == 10
)

achievement(
    id = 0,
    title = "Carlos Sainz", points = 50, type="missable",
    description = "Win the World Championship [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && isRallyMonteCarloSelected() && isRallyAcropolisSelected() && isRally1000LakesSelected() &&
              getRallySanRemoPoints() != 0xFF && getRallyMonteCarloPoints() != 0xFF && getRallyAcropolisPoints() != 0xFF && getRally1000LakesPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() == 10 &&
              getWorldChampionshipPosition() == 0
)


// Leaderboards - Stages
// ---------------------

for st in rally_sanremo_stages {
    leaderboard(
        id = rally_sanremo_stages[st]["idLeaderboard"], 
        title = format("Rally San Remo Stage {0} - {1}", rally_sanremo_stages[st]["stage"], rally_sanremo_stages[st]["name"]),
        description = format("Leaderboard Rally San Remo Stage {0} - {1} [1p mode]", rally_sanremo_stages[st]["stage"], rally_sanremo_stages[st]["name"]),
        start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                 isRallySanRemoSelected() && isPlayingRallySanRemo() &&
                  getCurrentStage() == st &&
                  getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                  repeated(4, getChronoTime() > prev(getChronoTime())) &&
                  repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                  never(getChronoTime() == 0xFFFF),
        cancel = getChronoTime() == 0xFFFF, // When time exceeded value 0xFFFF
        submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
                getChronoTime() == 0 &&
                getChronoFrame() == 0 &&
                prev(getChronoTime()) >= 450 && // To prevent errors
                never(getChronoTime() == 0xFFFF),
        value  = getCentisecStageTime(),
        format = "MILLISECS", lower_is_better = true
    )
}

for st in rally_montecarlo_stages {
    leaderboard(
        id = rally_montecarlo_stages[st]["idLeaderboard"], 
        title = format("Rally Monte-Carlo Stage {0} - {1}", rally_montecarlo_stages[st]["stage"], rally_montecarlo_stages[st]["name"]),
        description = format("Leaderboard Rally Monte-Carlo Stage {0} - {1} [1p mode]", rally_montecarlo_stages[st]["stage"], rally_montecarlo_stages[st]["name"]),
        start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                 isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo() &&
                  getCurrentStage() == st &&
                  getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                  repeated(4, getChronoTime() > prev(getChronoTime())) &&
                  repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                  never(getChronoTime() == 0xFFFF),
        cancel = getChronoTime() == 0xFFFF, // When time exceeded value 0xFFFF
        submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
                getChronoTime() == 0 &&
                getChronoFrame() == 0 &&
                prev(getChronoTime()) >= 450 && // To prevent errors
                never(getChronoTime() == 0xFFFF),
        value  = getCentisecStageTime(),
        format = "MILLISECS", lower_is_better = true
    )
}

for st in rally_acropolis_stages {
    leaderboard(
        id = rally_acropolis_stages[st]["idLeaderboard"], 
        title = format("Rally Acropolis Stage {0} - {1}", rally_acropolis_stages[st]["stage"], rally_acropolis_stages[st]["name"]),
        description = format("Leaderboard Rally Acropolis Stage {0} - {1} [1p mode]", rally_acropolis_stages[st]["stage"], rally_acropolis_stages[st]["name"]),
        start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                 isRallyAcropolisSelected() && isPlayingRallyAcropolis() &&
                  getCurrentStage() == st &&
                  getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                  repeated(4, getChronoTime() > prev(getChronoTime())) &&
                  repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                  never(getChronoTime() == 0xFFFF),
        cancel = getChronoTime() == 0xFFFF, // When time exceeded value 0xFFFF
        submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
                getChronoTime() == 0 &&
                getChronoFrame() == 0 &&
                prev(getChronoTime()) >= 450 && // To prevent errors
                never(getChronoTime() == 0xFFFF),
        value  = getCentisecStageTime(),
        format = "MILLISECS", lower_is_better = true
    )
}

for st in rally_1000lakes_stages {
    leaderboard(
        id = rally_1000lakes_stages[st]["idLeaderboard"], 
        title = format("Rally of the 1000 Lakes Stage {0} - {1}", rally_1000lakes_stages[st]["stage"], rally_1000lakes_stages[st]["name"]),
        description = format("Leaderboard Rally of the 1000 Lakes Stage {0} - {1} [1p mode]", rally_1000lakes_stages[st]["stage"], rally_1000lakes_stages[st]["name"]),
        start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                 isRally1000LakesSelected() && isPlayingRally1000Lakes() &&
                  getCurrentStage() == st &&
                  getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                  repeated(4, getChronoTime() > prev(getChronoTime())) &&
                  repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                  never(getChronoTime() == 0xFFFF),
        cancel = getChronoTime() == 0xFFFF, // When time exceeded value 0xFFFF
        submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
                getChronoTime() == 0 &&
                getChronoFrame() == 0 &&
                prev(getChronoTime()) >= 450 && // To prevent errors
                never(getChronoTime() == 0xFFFF),
        value  = getCentisecStageTime(),
        format = "MILLISECS", lower_is_better = true
    )
}

// Leaderboards - Rallies
// ---------------------
/*
leaderboard(
    id = 0, 
    title = "Rally San Remo",
    description = "Leaderboard Rally San Remo",
    start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
             isRallySanRemoSelected() && isPlayingRallySanRemo() &&
              getCurrentStage() == 0 &&
              getChronoTime() == 2 && prev(getChronoTime()) == 1 &&
              getChronoFrame() == 0 && prev(getChronoFrame()) == 5,
    cancel = getChronoTime() == 0xFFFF, // When time exceeded value 0xFFFF
    submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
            getChronoTime() == 0 &&
            getChronoFrame() == 0 &&
            prev(getChronoTime()) >= 450 && // To prevent errors
            never(getChronoTime() == 0xFFFF),
    value  = getCentisecStageTime(),
    format = "MILLISECS", lower_is_better = true
)
*/


// Leaderboard Score Points TODO: Meterle lo de la arrancada del stage para el start
// ------------------------
leaderboard(
        id = 127131, 
        title = "Total Score Points",
        description = "Total Score Points [1p mode | Only 1 credit]",
        start  = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
                (isRallySanRemoSelected() || isRallyMonteCarloSelected() || isRallyAcropolisSelected() || isRally1000LakesSelected()) &&
                !isGameFinished() && getScorePoints() < 100 && // If the leaderboard starts after 0,5 seconds there are some points collected (5 points)
                getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                repeated(4, getChronoTime() > prev(getChronoTime())) &&
                repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                never(getChronoTime() == 0xFFFF),
        cancel = getExtraCreditsUsed() > 0,
        submit = isGameFinished(),
        value  = getScorePoints(),
        format = "POINTS", lower_is_better = false
    )


