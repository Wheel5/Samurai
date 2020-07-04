SAMURAI = SAMURAI or { }
local sam = SAMURAI
local EM = GetEventManager()

local cr = sam.Instance:New(1051, nil, nil)

cr:AddAlert(sam.TimerNotification:New("ShockingSmash", "2bcaff", "Smash", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {105780}, false))
cr:AddAlert(sam.TimerNotification:New("DirectCurrent", "00caff", "Current", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {105380}, false))
cr:AddAlert(sam.TimerNotification:New("NocturnalsFavor", "ca4fff", "Favor", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {104535}, true))

cr:AddAlert(sam.ActiveNotification:New(nil, nil, "Creeper", "ff2e85", EVENT_COMBAT_EVENT, ACTION_RESULT_BEGIN, {105016}, "Creeper spawning!", 2000, false))

table.insert(sam.instances, cr)
