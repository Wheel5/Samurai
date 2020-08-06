SAMURAI = SAMURAI or { }
local sam = SAMURAI
local WM = GetWindowManager()
local SM = SCENE_MANAGER

sam.UI = { }
sam.UI.activeAlerts = { }

function sam._onMoveStop()
	local acx, acy = sam.UI.activeAlerts[1]:GetCenter()
	local tcx, tcy = sam.UI.timedAlert:GetCenter()
	--df("%f, %f", acx, acy)
	--df("%f, %f", tcx, tcy)
	sam.savedVars.activeCenterX = acx
	sam.savedVars.activeCenterY = acy
	sam.savedVars.timedCenterX = tcx
	sam.savedVars.timedCenterY = tcy
end

function sam.UI.spawnNotificationFrame()
	local newFrameNum = #sam.UI.activeAlerts + 1
	sam.UI.activeAlerts[newFrameNum] = WM:CreateControlFromVirtual("SAMURAI_NOTI_" .. newFrameNum, sam.UI.window, "NotificationTemplate")
	sam.UI.activeAlerts[newFrameNum]:SetAnchor(BOTTOM, sam.UI.activeAlerts[newFrameNum - 1], TOP, 0, 10)
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
	if sam.UI.activeAlerts[frameNum] then
		sam.UI.activeAlerts[frameNum]:SetHidden(true)
	end
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
	sam.UI.timedAlert:SetMovable(not value)
	sam.UI.timedAlert:SetMouseEnabled(not value)
	for num,frame in ipairs(sam.UI.activeAlerts) do
		frame:SetHidden(value)
		frame:SetText("Notification #"..num)
	end
	sam.UI.activeAlerts[1]:SetMovable(not value)
	sam.UI.activeAlerts[1]:SetMouseEnabled(not value)
end

function sam.buildDisplay()
	local window = WM:CreateTopLevelWindow("SAMURAI_DISPLAY")
	--window:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	window:SetAnchorFill()
	window:SetMouseEnabled(false)
	window:SetMovable(false)
	window:SetHidden(false)
	window:SetResizeToFitDescendents(true)

	local noti1 = WM:CreateControlFromVirtual("SAMURAI_NOTI_1", window, "NotificationTemplate")
	noti1:SetAnchor(CENTER, window, TOPLEFT, sam.savedVars.activeCenterX, sam.savedVars.activeCenterY)
	noti1:SetHandler("OnMoveStop", function(...) sam._onMoveStop() end)
	noti1:SetText("Notification #1")

	local timedAlert = WM:CreateControlFromVirtual("SAMURAI_TIMED_ALERT", window, "NotificationTemplate")
	timedAlert:SetAnchor(CENTER, window, TOPLEFT, sam.savedVars.timedCenterX, sam.savedVars.timedCenterY)
	timedAlert:SetFont("$(BOLD_FONT)|$(KB_40)|thick-outline")
	timedAlert:SetColor(1, 1, .25)
	timedAlert:SetText("Timer Notification")
	timedAlert:SetHandler("OnMoveStop", function(...) sam._onMoveStop() end)

	sam.UI.window = window
	sam.UI.windowFragment = ZO_HUDFadeSceneFragment:New(sam.UI.window)
	sam.UI.timedAlert = timedAlert
	sam.UI.activeAlerts[1] = noti1
	sam.UI.setHudDisplay(true)
end

