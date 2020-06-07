settings {
    "lobby": {
        "spectatorSlots": 12,
        "team1Slots": 6,
        "team2Slots": 6,
        "returnToLobby": "never",
        "teamBalancing": "afterMirrorMatch"
    },
    "gamemodes": {
        "elimination": {
            "disabledMaps": [
                "ayutthaya",
                "blackForest",
                "blackForestWinter",
                "castillo",
                "ecopointAntarctica",
                "ecopointAntarcticaWinter",
                "necropolis",
                "workshopChamber",
                "workshopExpanse",
                "workshopExpanseNight",
                "workshopIsland",
                "workshopIslandNight"
            ],
            "enableTiebreaker": false,
            "drawTime": 180,
            "scoreToWin": 5
        },
        "general": {
            "gamemodeStartTrigger": "immediately",
            "heroLimit": "off",
            "enableKillCam": false,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "allTeams": {
            "mercy": {
                "damageDealt%": 500,
                "damageReceived%": 500,
                "ability1Cooldown%": 25,
                "healingDealt%": 10,
                "healingReceived%": 10,
                "health%": 25,
                "movementSpeed%": 175,
                "projectileSpeed%": 175,
                "ultGen%": 500,
                "weaponsEnabled": "blaster"
            },
            "enabledHeroes": [
                "mercy"
            ]
        }
    }
}
