SAMURAI = SAMURAI or { }
local sam = SAMURAI

local gen = sam.Instance:New(-1, nil, nil)

--gen:AddAlert(sam.TimerNotification:New("", "00FFFF", "Geyser", EVENT_COMBAT_EVENT, {11024}, true))
--gen:AddAlert(sam.ActiveNotification:New(nil, nil, "Pulverize", "00FFFF", EVENT_COMBAT_EVENT, {3860}, "Pulverize", 2000, true))

gen:AddAlert(sam.TimerNotification:New("TakingAim", "ffcb30", "Snipe", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {91736, 70695, 78781}, true))
gen:AddAlert(sam.TimerNotification:New("HeavyAttack", "e7ff30", "HA", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {14096, 40203, 49606}, true))
gen:AddAlert(sam.TimerNotification:New("Bash", "38afff", "Bash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {76538, 47466}, true))
gen:AddAlert(sam.TimerNotification:New("UpperCut", "ff681c", "Uppercut", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {29378, 70809, 24648, 47488, 82735}, true))
gen:AddAlert(sam.TimerNotification:New("AnvilCracker", "ff421c", "Animal Cracker", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {119817, 86914}, true))
gen:AddAlert(sam.TimerNotification:New("Crushing Blow", "ffd91c", "Crushing Blow", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {27826, 25034}, true))
gen:AddAlert(sam.TimerNotification:New("Boulder", "ff1cd9", "Boulder", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {49311}, true))
gen:AddAlert(sam.TimerNotification:New("Slam", "bfff1c", "Slam", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {50547}, true))
gen:AddAlert(sam.TimerNotification:New("powerBash", "1cffc2", "Power Bash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {29400}, true))

--gen:AddAlert(sam.ActiveNotification:New(nil, nil, "SoulCage", "00FFFF", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {22363, 73925}, "Soul Cage!", 3000, false))
sam.generalAlerts = gen

