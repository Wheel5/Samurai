SAMURAI = SAMURAI or { }
local sam = SAMURAI
local WM = GetWindowManager()
local SM = SCENE_MANAGER

sam.UI = { }
sam.UI.activeAlerts = { }

function sam.UI.spawnNotificationFrame()
	local newFrameNum = #sam.UI.activeAlerts + 1
	sam.UI.activeAlerts[newFrameNum] = WM:CreateControlFromVirtual("SAMURAI_NOTI_" .. newFrameNum, sam.UI.window, "NotificationTemplate")
	sam.UI.activeAlerts[newFrameNum]:SetAnchor(CENTER, GuiRoot, CENTER, 0, (-50 * newFrameNum) - 100)
	sam.UI.activeAlerts[newFrameNum]:SetText("Notification #" .. tostring(newFrameNum))
	return newFrameNum
end

function sam.UI.getAvailableNotificationFrame()
	for num,frame in ipairs(sam.UI.activeAlerts) do
		if frame:IsControlHidden() then
			--frame:SetHidden(false)
			return num
		end
	end
	return sam.UI.spawnNotificationFrame()
end

function sam.UI.displayAlert(frameNum, formattedMessage)
	sam.UI.activeAlerts[frameNum]:SetText(formattedMessage)
	sam.UI.activeAlerts[frameNum]:SetHidden(false)
end

function sam.UI.hideAlert(frameNum)
	sam.UI.activeAlerts[frameNum]:SetHidden(true)
end

function sam.UI.setHudDisplay(value)
	if value then
		SM:GetScene("hud"):AddFragment(sam.UI.windowFragment)
		SM:GetScene("hudui"):AddFragment(sam.UI.windowFragment)
	else
		SM:GetScene("hud"):RemoveFragment(sam.UI.windowFragment)
		SM:GetScene("hudui"):RemoveFragment(sam.UI.windowFragment)
	end
	sam.UI.window:SetHidden(value)
	sam.UI.timedAlert:SetHidden(value)
	sam.UI.timedAlert:SetText("Timed Alert")
	for num,frame in ipairs(sam.UI.activeAlerts) do
		frame:SetHidden(value)
		frame:SetText("Notification #"..num)
	end
end

function sam.buildDisplay()
	local window = WM:CreateTopLevelWindow("SAMURAI_DISPLAY")
	window:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	window:SetMouseEnabled(false)
	window:SetMovable(false)
	window:SetHidden(false)
	window:SetResizeToFitDescendents(true)

	local noti1 = WM:CreateControlFromVirtual("SAMURAI_NOTI_1", window, "NotificationTemplate")
	noti1:SetAnchor(CENTER, window, CENTER, 0, -150)
	noti1:SetText("Notification #1")

	local timedAlert = WM:CreateControlFromVirtual("SAMURAI_TIMED_ALERT", window, "NotificationTemplate")
	timedAlert:SetAnchor(TOP, window, CENTER, 0, -120)
	timedAlert:SetFont("$(BOLD_FONT)|$(KB_32)|thick-outline")
	timedAlert:SetColor(1, 1, .25)
	timedAlert:SetText("Timer Notification")

	sam.UI.window = window
	sam.UI.windowFragment = ZO_HUDFadeSceneFragment:New(sam.UI.window)
	sam.UI.timedAlert = timedAlert
	sam.UI.activeAlerts[1] = noti1
	sam.UI.setHudDisplay(true)
end

