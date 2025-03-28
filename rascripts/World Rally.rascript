// World Rally
// #ID = 27016
// md5: e07e71e9d01b6aeb7622741b93a5b1fd - (Version 1.0, Checksum 0E56)

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
    return byte(0x003552) == 0 || byte(0x003552) == 0x72
}

function isInSelectionScreen() {
    return (byte(0x003552) == 0x10 || byte(0x003552) == 0x52) &&
        (!isRallySanRemoSelected() && !isRallyMonteCarloSelected() && !isRallyAcropolisSelected() && !isRally1000LakesSelected())
}

function IsInTitleScreen() {
return byte(0x003552) == 0 &&
        (!isRallySanRemoSelected() && !isRallyMonteCarloSelected() && !isRallyAcropolisSelected() && !isRally1000LakesSelected())    
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
        return (getChronoFrame() * 10) / 6            
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


// Rally ASCII Time functions
function getRallyMinutesASCII() => low4(0x00328F)
function getRallyFirstDigitSecondsASCII() => low4(0x003291)
function getRallySecondDigitSecondsASCII() => low4(0x003290)
function getRallyTenthsOfSecondASCII() => low4(0x003292)

// Rally time
function getCentisecRallyTime(){
    return (getRallyMinutesASCII()  * 6000) +
        (getRallyFirstDigitSecondsASCII() * 1000) +
        (getRallySecondDigitSecondsASCII() * 100) +
        (getRallyTenthsOfSecondASCII() * 10)
}


// Dictionary for all rallies and stages

rallies = {
    0: {
        "name": "Rally San Remo",
        "leaderboard": {
            "id": 127421,
            "title": "Rally San Remo",
            "description": "Leaderboard Rally San Remo [1p mode | Only 1 credit]"
        },
        "completed": {
            "id": 507130,
            "title": "Arrivederci San Remo",
            "description": "Complete Rally San Remo, Italy [1p mode | Only 1 credit]",
            "points": 5
        },
        "victory": {
            "id": 506658,
            "title": "Gladiator",
            "description": "Win Rally San Remo, Italy [1p mode | Only 1 credit]",
            "points": 10
        },
        "stages": {
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
    },
    1: {
        "name": "Rally Monte-Carlo",
        "leaderboard": {
            "id": 127422,
            "title": "Rally Monte-Carlo",
            "description": "Leaderboard Rally Monte-Carlo [1p mode | Only 1 credit]"
        },
        "completed": {
            "id": 507136,
            "title": "A walk along the Cote dAzur",
            "description": "Complete Rally MonteCarlo, France [1p mode | Only 1 credit]",
            "points": 5
        },
        "victory": {
            "id": 507059,
            "title": "Casino Royale",
            "description": "Win Rally MonteCarlo, France [1p mode | Only 1 credit]",
            "points": 10
        },
        "stages": {
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
    },
    2: {
        "name": "Rally Acropolis",
        "leaderboard": {
            "id": 127423,
            "title": "Rally Acropolis",
            "description": "Leaderboard Rally Acropolis [1p mode | Only 1 credit]"
        },
        "completed": {
            "id": 507131,
            "title": "Olympic Games",
            "description": "Complete Rally Acropolis, Greece [1p mode | Only 1 credit]",
            "points": 5
        },
        "victory": {
            "id": 507132,
            "title": "Greek God",
            "description": "Win Rally Acropolis, Greece [1p mode | Only 1 credit]",
            "points": 10
        },
        "stages": {
            0: {
                "idAchievement": 507123,
                "idLeaderboard": 127101,
                "name" : "Tarzan",
                "stage": 1,
                "winningTitle": "George Moschous",
                "winningPoints" : 2,
            },
            1: {
                "idAchievement": 507124,
                "idLeaderboard": 127102,    
                "name" : "Vari",
                "stage": 2,
                "winningTitle": "Anastasios Markouizos",
                "winningPoints" : 3,
            },
            2: {
                "idAchievement": 507125,    
                "idLeaderboard": 127103, 
                "name" : "Kinetta",
                "stage": 3,
                "winningTitle": "Tassos Livieratos",
                "winningPoints" : 5,
            }
        }
    },
    3: {
        "name": "Rally of the 1000 Lakes",
        "leaderboard": {
            "id": 127424,
            "title": "Rally of the 1000 Lakes",
            "description": "Leaderboard Rally of the 1000 Lakes [1p mode | Only 1 credit]"
        },
        "completed": {
            "id": 507137,
            "title": "Let it go, Let it go...",
            "description": "Complete Rally of the 1000 Lakes, Finland [1p mode | Only 1 credit]",
            "points": 5
        },
        "victory": {
            "id": 507133,
            "title": "King in the North",
            "description": "Win Rally 1000 Lakes, Finland [1p mode | Only 1 credit]",
            "points": 10
        },
        "stages": {
            0: {
                "idAchievement": 507126,
                "idLeaderboard": 127104,
                "name" : "Myhipaa",
                "stage": 1,
                "winningTitle": "Marcus Gronholm",
                "winningPoints" : 2,
            },
            1: {
                "idAchievement": 507127,
                "idLeaderboard": 127105,    
                "name" : "Konivuori",
                "stage": 2,
                "winningTitle": "Juha Kankkunen",
                "winningPoints" : 3,
            },
            2: {
                "idAchievement": 507128,    
                "idLeaderboard": 127106, 
                "name" : "Laajavuori",
                "stage": 3,
                "winningTitle": "Tommi Makinen",
                "winningPoints" : 5,
            }
        }
    },
}

// Lookups for Rich presence
// -------------------------
ralliesLookup = {
    0: "Rally San Remo",
    1: "Rally Monte-Carlo",
    2: "Rally Acropolis",
    3: "Rally of the 1000 Lakes"
}

stagesSanRemoLookup = {
    0: "Peranaldo",
    1: "Totip",
    2: "Ospedaletti"
}

stagesMonteCarloLookup = {
    0: "Moulinon",
    1: "Sisteron",
    2: "Col de Turini"
}

stagesAcropolisLookup = {
    0: "Tarzan",
    1: "Vari",
    2: "Kinetta"
}

stages1000LakesLookup = {
    0: "Myhipaa",
    1: "Konivuori",
    2: "Laajavuori"
}




// Achievement functions
// ---------------------

// Achievement function for completed rallies
function setAchievementCompleteRally(rallyId){
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() > 0
              
    if(rallyId == 0){
        trigger = trigger && isRallySanRemoSelected() && getRallySanRemoPoints() != 0xFF
    }
    else if (rallyId == 1){
        trigger = trigger && isRallyMonteCarloSelected() && getRallyMonteCarloPoints() != 0xFF
    }
    else if (rallyId == 2){
        trigger = trigger && isRallyAcropolisSelected() && getRallyAcropolisPoints() != 0xFF
    }
    else if (rallyId == 3){
        trigger = trigger && isRally1000LakesSelected() && getRally1000LakesPoints() != 0xFF
    }
    else {}
    
    achievement(id = rallies[rallyId]["completed"]["id"], 
                title = rallies[rallyId]["completed"]["title"],
                points = rallies[rallyId]["completed"]["points"],
                type="progression",
                description = rallies[rallyId]["completed"]["description"],
                trigger = trigger)
}

// Achievement function for victory in rallies
function setAchievementVictoryRally(rallyId){
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              getWorldChampionshipPoints() >= 20 &&
              getTotalRalliesCompleted() > 0
              
    if(rallyId == 0){
        trigger = trigger && isRallySanRemoSelected() && getRallySanRemoPoints() == 20
    }
    else if (rallyId == 1){
        trigger = trigger && isRallyMonteCarloSelected() && getRallyMonteCarloPoints() == 20
    }
    else if (rallyId == 2){
        trigger = trigger && isRallyAcropolisSelected() && getRallyAcropolisPoints() == 20
    }
    else if (rallyId == 3){
        trigger = trigger && isRally1000LakesSelected() && getRally1000LakesPoints() == 20
    }
    else {}
    
    achievement(id = rallies[rallyId]["victory"]["id"], 
                title = rallies[rallyId]["victory"]["title"],
                points = rallies[rallyId]["victory"]["points"],
                type= "missable",
                description = rallies[rallyId]["victory"]["description"],
                trigger = trigger)
}


// Achievement function for victory in rally stages
function setAchievementVictoryStage(rallyId, stage){
    id = rallies[rallyId]["stages"][stage]["idAchievement"]
    title = rallies[rallyId]["stages"][stage]["winningTitle"]
    points = rallies[rallyId]["stages"][stage]["winningPoints"]
    type = "missable"
    description = format("Win {0} Stage - {1} Stage {2} [1p mode]", 
            rallies[rallyId]["stages"][stage]["name"], 
            rallies[rallyId]["name"],
            rallies[rallyId]["stages"][stage]["stage"])
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  getCurrentStage() == stage &&
                  stageCleared() &&
                  getStagePosition() == 0
                  
    if(rallyId == 0){
        trigger = trigger && isRallySanRemoSelected() && isPlayingRallySanRemo()
    }
    else if (rallyId == 1){
        trigger = trigger && isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo()
    }
    else if (rallyId == 2){
        trigger = trigger && isRallyAcropolisSelected() && isPlayingRallyAcropolis()
    }
    else if (rallyId == 3){
        trigger = trigger && isRally1000LakesSelected() && isPlayingRally1000Lakes()
    }
    else {}
    
    achievement(id=id, title=title, points=points, type=type, description=description, trigger=trigger)
}

// Achievement function for game completed
function setGameCompletedAchievement(id, title, points, type, description, isPositionRequired, positionReq, extraCredits){
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == extraCredits &&
              isRallySanRemoSelected() && isRallyMonteCarloSelected() && isRallyAcropolisSelected() && isRally1000LakesSelected() &&
              getRallySanRemoPoints() != 0xFF && getRallyMonteCarloPoints() != 0xFF && getRallyAcropolisPoints() != 0xFF && getRally1000LakesPoints() != 0xFF &&
              getWorldChampionshipPoints() != 0xFF &&
              getTotalRalliesCompleted() == 10
              
     if(isPositionRequired){
         trigger = trigger && getWorldChampionshipPosition() <= positionReq
     }
     
     achievement(id=id, title=title, points=points, type=type, description=description, trigger=trigger)
}

// Leaderboard functions
// ---------------------

// Rally leaderboard
function setRallyLeaderboard(rallyId){
    start = isOnePlayerMode() && isNormalOrHigherDifficulty() && getExtraCreditsUsed() == 0 &&
              getCurrentStage() == 0 &&
              getChronoTime() == 2 && prev(getChronoTime()) == 1 &&
              getChronoFrame() == 0 && prev(getChronoFrame()) == 5
              
    cancel = getExtraCreditsUsed() > 0 || isGameFinished()
    
    if(rallyId == 0){
        start = start && isRallySanRemoSelected() && isPlayingRallySanRemo()
        cancel = cancel || !isPlayingRallySanRemo()
    }
    else if (rallyId == 1){
        start = start && isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo()
        cancel = cancel || !isPlayingRallyMonteCarlo()
    }
    else if (rallyId == 2){
        start = start && isRallyAcropolisSelected() && isPlayingRallyAcropolis()
        cancel = cancel || !isPlayingRallyAcropolis()
    }
    else if (rallyId == 3){
        start = start && isRally1000LakesSelected() && isPlayingRally1000Lakes()
        cancel = cancel || !isPlayingRally1000Lakes()
    }
    else {}
    
    leaderboard(id = rallies[rallyId]["leaderboard"]["id"],
                title = rallies[rallyId]["leaderboard"]["title"],
                description = rallies[rallyId]["leaderboard"]["description"],
                start = start,
                cancel = cancel,
                submit = getCurrentStage() == 2 && (prev(getCentisecRallyTime()) < getCentisecRallyTime()),
                value  = getCentisecRallyTime(),
                format = "MILLISECS", 
                lower_is_better = true                
    )
}

// Stage leaderboard
function setStageLeaderboard(rallyId, stage){
    id = rallies[rallyId]["stages"][stage]["idLeaderboard"]
    title = format("{0} Stage {1} - {2}", 
            rallies[rallyId]["name"],
            rallies[rallyId]["stages"][stage]["stage"],             
            rallies[rallyId]["stages"][stage]["name"])
    description = format("Leaderboard {0} Stage {1} - {2} [1p mode]", 
            rallies[rallyId]["name"],
            rallies[rallyId]["stages"][stage]["stage"],             
            rallies[rallyId]["stages"][stage]["name"])
    start  = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
                  getCurrentStage() == stage &&
                  getChronoTime() == 5 && prev(getChronoTime()) == 4 &&
                  repeated(4, getChronoTime() > prev(getChronoTime())) &&
                  repeated(20, getChronoFrame() > prev(getChronoFrame())) &&
                  never(getChronoTime() == 0xFFFF)
                  
    cancel = getChronoTime() == 0xFFFF && prev(getChronoTime() == 600) // When time exceeded value goes from 600 to 0xFFFF
    submit = repeated(400, getChronoTime() > prev(getChronoTime())) && 
            getChronoTime() == 0 &&
            getChronoFrame() == 0 &&
            prev(getChronoTime()) >= 450 && // To prevent errors
            getScorePoints() > prior(getScorePoints()) + 10 && // During the Chrono the points only increase max 9 (according to the current speed) in a frame, when finish the stage increase a lot more
            never(getChronoTime() == 0xFFFF)
    value  = getCentisecStageTime()
    
    
    if(rallyId == 0){
        start = start && isRallySanRemoSelected() && isPlayingRallySanRemo()
        cancel = cancel || !isPlayingRallySanRemo()
    }
    else if (rallyId == 1){
        start = start && isRallyMonteCarloSelected() && isPlayingRallyMonteCarlo()
        cancel = cancel || !isPlayingRallyMonteCarlo()
    }
    else if (rallyId == 2){
        start = start && isRallyAcropolisSelected() && isPlayingRallyAcropolis()
        cancel = cancel || !isPlayingRallyAcropolis()
    }
    else if (rallyId == 3){
        start = start && isRally1000LakesSelected() && isPlayingRally1000Lakes()
        cancel = cancel || !isPlayingRally1000Lakes()
    }
    else {}
    
 
    leaderboard(id=id, title=title, description=description, start=start, cancel=cancel, submit=submit, value=value, format = "MILLISECS", lower_is_better = true)   
}



// Achievements - Stages
// ---------------------

// Win any stage
achievement(
    id = 507129,
    title = "Fast and Furious", points = 1, type="missable",
    description = "Win a rally stage [1p mode]",
    trigger = isOnePlayerMode() && isNormalOrHigherDifficulty() &&
              stageCleared() &&
              getStagePosition() == 0
)

// Achievement every stage
for ral in rallies {
    for st in rallies[ral]["stages"]{
        setAchievementVictoryStage(ral, st)
    }
}


// Achievements - Rallies Completed
// --------------------------------

for raId in rallies {
    setAchievementCompleteRally(raId)
}


// Achievements - Rallies Won
// --------------------------
for raId in rallies {
    setAchievementVictoryRally(raId)
}


// Achievements - Game Completed
// -----------------------------
setGameCompletedAchievement(id = 507134,
    title = "The job is done", points = 25, type="win_condition",
    description = "Complete the game [1p mode | Only 1 credit]",
    isPositionRequired = false, positionReq = 0, extraCredits = 0)
    
setGameCompletedAchievement(id = 507138,
    title = "Touching the glory", points = 50, type="missable",
    description = "Finish in third position, or better, in the World Championship [1p mode | Only 1 credit]",
    isPositionRequired = true, positionReq = 2, extraCredits = 0)
    
setGameCompletedAchievement(id = 507135,
    title = "Carlos Sainz", points = 50, type="missable",
    description = "Win the World Championship [1p mode | Max 3 credits]",
    isPositionRequired = true, positionReq = 0, extraCredits = 2)    
    

// Leaderboards - Stages
// ---------------------

for ral in rallies {
    for st in rallies[ral]["stages"]{
        setStageLeaderboard(ral, st)
    }
}


// Leaderboards - Rallies
// ---------------------

for raId in rallies{
    setRallyLeaderboard(raId)    
}


// Leaderboard Score Points
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


// Rich Presence
// -------------

rich_presence_conditional_display(IsInTitleScreen(), "In title screen")
rich_presence_conditional_display(isInSelectionScreen(), "In Rally selection screen")
rich_presence_conditional_display(isGameFinished() && getWorldChampionshipPosition() == 0, "Game finished, 🥇 World Championship,💰:{0}, 🔁 {1}",
                        rich_presence_value("Points", getScorePoints()),
                        rich_presence_value("Continues", getExtraCreditsUsed())
)
rich_presence_conditional_display(isGameFinished() && getWorldChampionshipPosition() == 1, "Game finished, 🥈 World Championship,💰:{0}, 🔁 {1}",
                        rich_presence_value("Points", getScorePoints()),
                        rich_presence_value("Continues", getExtraCreditsUsed())
)
rich_presence_conditional_display(isGameFinished() && getWorldChampionshipPosition() == 2, "Game finished, 🥉 World Championship,💰:{0}, 🔁 {1}",
                        rich_presence_value("Points", getScorePoints()),
                        rich_presence_value("Continues", getExtraCreditsUsed())
)
rich_presence_conditional_display(isGameFinished(), "Game finished, 🏅{0} World Championship, 💰:{1}, 🔁 {2}",
                        rich_presence_value("Position", getWorldChampionshipPosition() + 1),
                        rich_presence_value("Points", getScorePoints()),
                        rich_presence_value("Continues", getExtraCreditsUsed())
)
                          


rich_presence_conditional_display(getCurrentRally() == 0, "Playing {0}, {1}, 🚩:{2}, 🔁:{3}, 💰:{4}",
                        rich_presence_lookup("Rally", getCurrentRally(), ralliesLookup),
                        rich_presence_lookup("StageSanRemo", getCurrentStage(), stagesSanRemoLookup),
                        rich_presence_value("StageNumber", getCurrentStage() + 1),
                        rich_presence_value("Continues", getExtraCreditsUsed()),
                        rich_presence_value("Points", getScorePoints())                        
)
                                  
rich_presence_conditional_display(getCurrentRally() == 1, "Playing {0}, {1}, 🚩:{2}, 🔁:{3}, 💰:{4}",
                        rich_presence_lookup("Rally", getCurrentRally(), ralliesLookup),
                        rich_presence_lookup("StageMonteCarlo", getCurrentStage(), stagesMonteCarloLookup),
                        rich_presence_value("StageNumber", getCurrentStage() + 1),
                        rich_presence_value("Continues", getExtraCreditsUsed()),
                        rich_presence_value("Points", getScorePoints()) 
)

rich_presence_conditional_display(getCurrentRally() == 2, "Playing {0}, {1}, 🚩:{2}, 🔁:{3}, 💰:{4}",
                        rich_presence_lookup("Rally", getCurrentRally(), ralliesLookup),
                        rich_presence_lookup("StageAcropolis", getCurrentStage(), stagesAcropolisLookup),
                        rich_presence_value("StageNumber", getCurrentStage() + 1),
                        rich_presence_value("Continues", getExtraCreditsUsed()),
                        rich_presence_value("Points", getScorePoints()) 
)

rich_presence_display("Playing {0}, {1}, 🚩:{2}, 🔁:{3}, 💰:{4}",
                        rich_presence_lookup("Rally", getCurrentRally(), ralliesLookup),
                        rich_presence_lookup("Stage1000Lakes", getCurrentStage(), stages1000LakesLookup),
                        rich_presence_value("StageNumber", getCurrentStage() + 1),
                        rich_presence_value("Continues", getExtraCreditsUsed()),
                        rich_presence_value("Points", getScorePoints()) 
)

