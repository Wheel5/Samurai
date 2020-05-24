SAMURAI = SAMURAI or { }
local sam = SAMURAI
local EM = GetEventManager()

local gen = sam.Instance:New(-1, nil, nil)
local divePlayers = { }

local function dive(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	sam.debug("handler fired for %s", "dive")
	if hitValue < 100 then return end
	if result == ACTION_RESULT_BEGIN then
		local target = sam.LUNITS.GetDisplayNameForUnitId(targetUnitId)
		if not divePlayers[target] then
			divePlayers[target] = {sam.UI.getAvailableNotificationFrame(), 0}
			local text = string.format("|c00FFFFHackwing Dive Targetting|r |cFFFF00%s|r", target)
			sam.UI.displayAlert(divePlayers[target][1], text)
		end
		divePlayers[target][2] = divePlayers[target][2] + 1
		PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)
		zo_callLater(function()
			divePlayers[target][2] = divePlayers[target][2] - 1
			if divePlayers[target][2] <= 0 then
				sam.UI.hideAlert(divePlayers[target][1])
				divePlayers[target] = nil
			end
		end, 2500)
	end
end

local function registerDive()
	EM:RegisterForEvent(sam.name.."Dive85395", EVENT_COMBAT_EVENT, dive)
	EM:AddFilterForEvent(sam.name.."Dive85395", EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, 85395)
end

--gen:AddAlert(sam.TimerNotification:New("", "00FFFF", "Geyser", EVENT_COMBAT_EVENT, {11024}, true))
--gen:AddAlert(sam.ActiveNotification:New(nil, nil, "Pulverize", "00FFFF", EVENT_COMBAT_EVENT, {3860}, "Pulverize", 2000, true))

gen:AddAlert(sam.TimerNotification:New("TakingAim", "ffcb30", "Snipe", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {91736, 70695, 78781, 113146, 111209, 110898}, true))
gen:AddAlert(sam.TimerNotification:New("HeavyAttack", "e7ff30", "HA", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {14096, 40203, 120893, 49606, 111634}, true))
gen:AddAlert(sam.TimerNotification:New("Bash", "38afff", "Bash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {76538, 47466}, true))
gen:AddAlert(sam.TimerNotification:New("HeavySlash", "ff681c", "Heavy Slash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {128527, 115928}, true))
gen:AddAlert(sam.TimerNotification:New("UpperCut", "ff681c", "Uppercut", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {29378, 70809, 24648, 47488, 82735}, true))
gen:AddAlert(sam.TimerNotification:New("AnvilCracker", "ff421c", "Animal Cracker", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {119817, 86914}, true))
gen:AddAlert(sam.TimerNotification:New("Crushing Blow", "ffd91c", "Crushing Blow", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {27826, 25034}, true))
gen:AddAlert(sam.TimerNotification:New("Boulder", "ff1cd9", "Boulder", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {49311, 115942}, true))
gen:AddAlert(sam.TimerNotification:New("Slam", "bfff1c", "Slam", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {50547}, true))
gen:AddAlert(sam.TimerNotification:New("powerBash", "1cffc2", "Power Bash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {29400}, true))
gen:AddAlert(sam.TimerNotification:New("LavaWhip", "ff6219", "Whip", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {110814, 111161}, true))
gen:AddAlert(sam.TimerNotification:New("TopplingBlow", "e134eb", "Toppling", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {111163}, true))
gen:AddAlert(sam.TimerNotification:New("ClashofBones", "00e5ff", "Clash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {92892}, true))

gen:AddAlert(sam.ActiveNotification:New(nil, nil, "LavaGeyser", "ff3019", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {112063}, "Geyser, dodge!", 2000, true))
gen:AddAlert(sam.ActiveNotification:New(nil, nil, "Rake", "00FFFF", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {111339}, "Hackwing Rake Incoming", 2000, false))
gen:AddAlert(sam.ActiveNotification:New(registerDive, nil))

--gen:AddAlert(sam.ActiveNotification:New(nil, nil, "SoulCage", "00FFFF", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {22363, 73925}, "Soul Cage!", 3000, false))
sam.generalAlerts = gen

