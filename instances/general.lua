SAMURAI = SAMURAI or { }
local sam = SAMURAI

local gen = sam.Instance:New(-1, nil, nil)

gen:AddAlert(sam.TimerNotification:New("Geyser", "00FFFF", "Geyser", EVENT_COMBAT_EVENT, {11024}, true))
gen:AddAlert(sam.ActiveNotification:New(nil, nil, "Geyser", "00FFFF", EVENT_COMBAT_EVENT, {11024}, "Geyser", 2000, true))

sam.generalAlerts = gen

