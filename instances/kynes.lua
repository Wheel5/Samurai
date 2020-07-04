SAMURAI = SAMURAI or { }
local sam = SAMURAI
local EM = GetEventManager()

local ka = sam.Instance:New(1196, nil, nil)

ka:AddAlert(sam.TimerNotification:New("WrathofTides", "2bcaff", "Wrath", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {134050}, true))
ka:AddAlert(sam.TimerNotification:New("CrashingWave", "19e0ff", "Wave", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {134196}, false))
--ka:AddAlert(sam.TimerNotification:New("CrashingWave", "19e0ff", "Wave", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {134196}, false))
--ka:AddAlert(sam.TimerNotification:New("kaMeteor", "19e000", "Meteor", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {134023, 140606, 140603, 134021}, false))

table.insert(sam.instances, ka)
