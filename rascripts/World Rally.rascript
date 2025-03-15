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

// Get how many extra credits have been used
function getExtraCreditsUsed() => byte(0x003538)

// One player mode and only one "active"
function isOnePlayerMode() {
    return byte(0x00354E) == 1 && byte(0x0033AC) == 1
}

// Get Chrono value during the stage
    // 472 = 47.2
    // At the end of the stage go to 0
function getChronoTime() => word(0x003F08)


// Custom functions
function stageCleared() {
    return repeated(400, getChronoTime() > prev(getChronoTime())) && 
           getChronoTime() == 0 &&
           never(repeated(10, getChronoTime() > 600))
}

function getMilisecStageTime(){
//    return prior(getChronoTime()) * 10
    return prev(getChronoTime()) * 10    
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
        "name" : "Peranaldo",
        "stage": 1,
        "winningtitle": "Miki Biasion",
        "winningpoints" : 1,
    },
    1: {
        "name" : "Totip",
        "stage": 2,
        "winningtitle": "Giandomenico Basso",
        "winningpoints" : 3,
    },
    2: {
        "name" : "Ospedaletti",
        "stage": 3,
        "winningtitle": "Paolo Andreucci",
        "winningpoints" : 5,
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
        title = rally_sanremo_stages[st]["winningtitle"], points = rally_sanremo_stages[st]["winningpoints"], type="missable",
        description = "Win " + rally_sanremo_stages[st]["name"] + " Stage - Rally SanRemo Stage "+ rally_sanremo_stages[st]["stage"] + " [1p mode]",
        trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  isRallySanRemoSelected() && isPlayingRallySanRemo() &&
                  getCurrentStage() == st &&
                  stageCleared() &&
                  getStagePosition() == 0
    )    
}


achievement(
    title = "Didier Auriol", points = 2, type="missable",
    description = "Win Moulinon Stage - Rally Monte-Carlo Stage 1 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo() &&
              getCurrentStage() == 0 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Sebastian Ogier", points = 3, type="missable",
    description = "Win Sisteron Stage - Rally Monte-Carlo Stage 2 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo() &&
              getCurrentStage() == 1 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Sebastian Loeb", points = 5, type="missable",
    description = "Win Col de Turini Stage - Rally Monte-Carlo Stage 3 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo() &&
              getCurrentStage() == 2 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "George Moschous", points = 2, type="missable",
    description = "Win Tarzan Stage - Rally Acropolis Stage 1 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyAcropolisSelected() && isPlayingRallyAcropolis() &&
              getCurrentStage() == 0 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Anastasios Markouizos", points = 3, type="missable",
    description = "Win Vari Stage - Rally Acropolis Stage 2 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyAcropolisSelected() && isPlayingRallyAcropolis() &&
              getCurrentStage() == 1 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Tassos Livieratos", points = 5, type="missable",
    description = "Win Kinetta Stage - Rally Acropolis Stage 3 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallyAcropolisSelected() && isPlayingRallyAcropolis() &&
              getCurrentStage() == 2 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Marcus Gronholm", points = 2, type="missable",
    description = "Win Myhipaa Stage - Rally 1000 Lakes Stage 1 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRally1000LakesSelected() && isPlayingRally1000Lakes() &&
              getCurrentStage() == 0 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Juha Kankkunen", points = 3, type="missable",
    description = "Win Konivuori Stage - Rally 1000 Lakes Stage 2 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRally1000LakesSelected() && isPlayingRally1000Lakes() &&
              getCurrentStage() == 1 &&
              stageCleared() &&
              getStagePosition() == 0
)

achievement(
    title = "Tommi Makinen", points = 5, type="missable",
    description = "Win Laajavuori Stage - Rally 1000 Lakes Stage 3 [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRally1000LakesSelected() && isPlayingRally1000Lakes() &&
              getCurrentStage() == 2 &&
              stageCleared() &&
              getStagePosition() == 0
)


// Achievements - Rallies Completed
// --------------------------------

achievement(
    title = "Arrivederci San Remo", points = 5, type="progression",
    description = "Complete Rally San Remo, Italy [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && getRallySanRemoPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    title = "A walk along the Cote dAzur", points = 5, type="progression",
    description = "Complete Rally MonteCarlo, France [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyMonteCarloSelected() && getRallyMonteCarloPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    title = "Olympic Games", points = 5, type="progression",
    description = "Complete Rally Acropolis, Greece [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyAcropolisSelected() && getRallyAcropolisPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    title = "Let it go, Let it go...", points = 5, type="progression",
    description = "Complete Rally of the 1000 Lakes, Finland [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRally1000LakesSelected() && getRally1000LakesPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() > 0
)

// Achievements - Rallies Won
// --------------------------

achievement(
    title = "Gladiator", points = 10, type="missable",
    description = "Win Rally San Remo, Italy [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && getRallySanRemoPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    title = "Casino Royale", points = 10, type="missable",
    description = "Win Rally MonteCarlo, France [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyMonteCarloSelected() && getRallyMonteCarloPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
    title = "Greek God", points = 10, type="missable",
    description = "Win Rally Acropolis, Greece [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallyAcropolisSelected() && getRallyAcropolisPoints() == 20 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
)

achievement(
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
    title = "The job is done", points = 25, type="win_condition",
    description = "Complete the game [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && isRallyMonteCarloSelected() && isRallyAcropolisSelected() && isRally1000LakesSelected() &&
              getRallySanRemoPoints() != 255 && getRallyMonteCarloPoints() != 255 && getRallyAcropolisPoints() != 255 && getRally1000LakesPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() == 10
)

achievement(
    title = "Carlos Sainz", points = 50, type="missable",
    description = "Win the World Championship [1p mode | Only 1 credit]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              isRallySanRemoSelected() && isRallyMonteCarloSelected() && isRallyAcropolisSelected() && isRally1000LakesSelected() &&
              getRallySanRemoPoints() != 255 && getRallyMonteCarloPoints() != 255 && getRallyAcropolisPoints() != 255 && getRally1000LakesPoints() != 255 &&
              getWorldChampionshipPoints() != 255 &&
              getTotalRalliesCompleted() == 10 &&
              getWorldChampionshipPosition() == 0
)


// Leaderboards - Stages
// ---------------------

leaderboard(
    id = 127072, title = "Leaderboard Rally San Remo Stage 1 - Peranaldo",
    description = "Leaderboard Rally San Remo Stage 1 - Peranaldo [1p mode]",
    start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallySanRemoSelected() && isPlayingRallySanRemo() &&
              getCurrentStage() == 0 &&
              repeated(400, getChronoTime() > prev(getChronoTime())) &&               
              never(repeated(10, getChronoTime() > 600)),
    cancel = getChronoTime() > 600,    
    submit = getChronoTime() == 0,
    value  = getMilisecStageTime(),
    format = "MILLISECS", lower_is_better = true
)

leaderboard(
    id = 127073, title = "Leaderboard Rally San Remo Stage 2 - Totip",
    description = "Leaderboard Rally San Remo Stage 2 - Totip [1p mode]",
    start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              isRallySanRemoSelected() && isPlayingRallySanRemo() &&
              getCurrentStage() == 1 &&
              repeated(400, getChronoTime() > prev(getChronoTime())) &&               
              never(repeated(10, getChronoTime() > 600)),
    cancel = getChronoTime() > 600,    
    submit = getChronoTime() == 0,
    value  = getMilisecStageTime(),
    format = "MILLISECS", lower_is_better = true
)
