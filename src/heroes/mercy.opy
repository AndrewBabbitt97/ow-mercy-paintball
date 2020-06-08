#!mainFile "../mercy-paintball.opy"

playervar hudIndex
playervar playersToResurrect
playervar resurrectingPlayers
playervar resurrectingPlayersIndex

rule "Mercy - Debug Mode":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isHoldingButton(Button.ABILITY_2) == true

    if DEBUG_MODE:
        #kill all teammates and reset ult
        kill(getLivingPlayers(eventPlayer.getTeam()).exclude(eventPlayer), eventPlayer)
        eventPlayer.setUltCharge(100)

rule "Mercy - Update Variables":
    @Event eachPlayer
    @Hero mercy

    #Keep the players to rez list up to date
    while true:
        eventPlayer.playersToResurrect = getPlayersInRadius(eventPlayer, 15, eventPlayer.getTeam(), LosCheck.OFF).exclude(getLivingPlayers(eventPlayer.getTeam()))
        wait(0.1)

rule "Mercy - Disable New Abilities":
    @Event eachPlayer
    @Hero mercy

    #disable resurrect ability and valkyrie ultimate
    eventPlayer.setAbility2Enabled(false)
    eventPlayer.disallowButton(Button.ULTIMATE)

rule "Mercy - Show Resurrection HUD":
    @Event eachPlayer
    @Hero mercy
    @Condition len(eventPlayer.playersToResurrect) != 0
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isAlive() == true

    #Padding to center the rez hud in the screen
    for eventPlayer.hudIndex in range(-1, 10, 1):
        hudSubheader(eventPlayer, " ", HudPosition.TOP, eventPlayer.hudIndex, Color.WHITE, HudReeval.NONE, SpecVisibility.DEFAULT)
    
    #players to rez count
    hudHeader(eventPlayer, "{0}x{1}".format(iconString(Icon.SKULL), len(eventPlayer.playersToResurrect)), HudPosition.TOP, 11, Color.WHITE, HudReeval.STRING, SpecVisibility.DEFAULT)
    hudSubheader(eventPlayer, l"{0} {1}".format(l"Teammate", l"Down"), HudPosition.TOP, 12, Color.YELLOW, HudReeval.NONE, SpecVisibility.DEFAULT)

rule "Mercy - Hide Resurrection HUD With No Players To Resurrect":
    @Event eachPlayer
    @Hero mercy
    @Condition len(eventPlayer.playersToResurrect) == 0

    destroyAllHudTexts()

rule "Mercy - Hide Resurrection HUD With No Ultimate":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() != 100

    destroyAllHudTexts()

rule "Mercy - Hide Resurrection HUD When Dead":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.isAlive() == false

    destroyAllHudTexts()

rule "Mercy - Old Resurrection Ultimate":
    @Event eachPlayer
    @Hero mercy
    @Condition eventPlayer.getUltCharge() == 100
    @Condition eventPlayer.isHoldingButton(Button.ULTIMATE) == true
    @Condition len(eventPlayer.playersToResurrect) > 0
    @Condition eventPlayer.isAlive() == true
    
    #reset ultimate charge
    eventPlayer.setUltCharge(0)

    #Original ult gave Mercy invulnerability for 2.25s and reset guardian angel
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 2.25)
    eventPlayer.setAbilityCooldown(Button.ABILITY_1, 0)

    #glowing effect on mercy
    playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.YELLOW, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer, 1)
    playEffect(getAllPlayers(), DynamicEffect.BUFF_EXPLOSION_SOUND, Color.WHITE, eventPlayer, 100)

    #get a snapshot of the current players to be resurrected
    eventPlayer.resurrectingPlayers = eventPlayer.playersToResurrect

    #loop through all of the players to be resurrected
    for eventPlayer.resurrectingPlayersIndex in range(len(eventPlayer.playersToResurrect)):

        #resurrect the player and make them invincible for 2.25s
        eventPlayer.resurrectingPlayers[eventPlayer.resurrectingPlayersIndex].resurrect()
        eventPlayer.resurrectingPlayers[eventPlayer.resurrectingPlayersIndex].setStatusEffect(eventPlayer, Status.INVINCIBLE, 2.25)

        #glowing effect on player
        playEffect(getAllPlayers(), DynamicEffect.GOOD_PICKUP_EFFECT, Color.YELLOW, eventPlayer.resurrectingPlayers[eventPlayer.resurrectingPlayersIndex], 1)
        playEffect(getAllPlayers(), DynamicEffect.GOOD_EXPLOSION, Color.YELLOW, eventPlayer.resurrectingPlayers[eventPlayer.resurrectingPlayersIndex], 1)
