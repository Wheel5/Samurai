SAMURAI = SAMURAI or { }
local sam = SAMURAI
local EM = GetEventManager()
local strformat = string.format

local timedAttackListMaster = { }
-- will be filled with sublists with the format:
-- { "attack name: ", "color", { table of attack timers } }
-- innermost table will be updated with times
-- attack table with be added or removed on registration

-- TODO: make sure when unregistering notifications in instances, we don't wipe out general notifications (or reregister if needed)

local function formatTimedAttackList()
	local countdownList = {}
	local countdownListFormatted = {}
	local t = GetGameTimeMilliseconds()

	for _, subList in ipairs(timedAttackListMaster) do
		local countdownSubList = { }	
		local formattedSubList = { }
		local subListString = ""
		for key, value in ipairs(subList[3]) do
			if value > t then
				table.insert(countdownSubList, value - t)
			end
		end

		if #countdownSubList > 0 then
			table.sort(countdownSubList)
			for _, value in ipairs(countdownSubList) do
				local color = value < 1000 and "FF0000" or subList[2]
				local format = "|c"..color.."%0.1f|r"
				table.insert(formattedSubList, strformat(format, value/1000))
			end
			subListString = subList[1] .. table.concat(formattedSubList, " / ")
			table.insert(countdownListFormatted, subListString)
		end
	end
	if #countdownListFormatted > 0 then
		return table.concat(countdownListFormatted, "\n")
	else
		return nil
	end
end

local function timedAttackCounter()
	local text = formatTimedAttackList()
	if not text or text == "" then
		EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
		sam.UI.timedAlert:SetHidden(true)
		for _,subList in ipairs(timedAttackListMaster) do
			for k in pairs(subList[3]) do
				subList[3][k] = nil
			end
		end
	else
		sam.UI.timedAlert:SetText(text)
	end
end

-- Adds notification to available frame or spawns new one if needed
local function displayNoti()
end


-- NOTIFICATION OBJECT PARENT
sam.Notification = ZO_Object:Subclass()

function sam.Notification:New()
	local noti = ZO_Object.New(self)
	noti:Initialize()
	return noti
end

function sam.Notification:InitializeParent(name, color, event, result, IDs, text)
	self.name = name
	self.color = color
	self.event = event
	self.IDs = IDs
	self.text = text
	self.result = result
	
end


-- TIMED ALERT OBJECT
sam.TimerNotification = sam.Notification:Subclass()

function sam.TimerNotification:New(name, color, text, event, result, IDs, targetPlayer)
	local timer = ZO_Object.New(self)
	timer:Initialize(name, color, text, event, result, IDs, targetPlayer)
	return timer
end

function sam.TimerNotification:Initialize(name, color, text, event, result, IDs, targetPlayer)
	self:InitializeParent(name, color, event, result, IDs, text)
	self.targetPlayer = targetPlayer
	--self.text = text
end

function sam.TimerNotification:Handler(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	sam.debug("handler fired for %s, targetPlayer is %s", self.name, tostring(self.targetPlayer))
	if (self.targetPlayer and targetType ~= COMBAT_UNIT_TYPE_PLAYER) or hitValue < 100 then return end

	if result == self.result then
		for k,v in ipairs(timedAttackListMaster) do
			if string.find(v[1], self.text) then
				sam.debug("found attack for %s", self.name)
				table.insert(v[3], GetGameTimeMilliseconds() + hitValue)
			end
		end
		timedAttackCounter()
		sam.UI.timedAlert:SetHidden(false)
		PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)

		EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
		EM:RegisterForUpdate(sam.name.."TimedAttackCountdown", 100, timedAttackCounter)
	end
end

function sam.TimerNotification:Register()
	sam.debug("registering timed alert with text: %s", self.text)
	local function wrapper(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		self:Handler(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	end
	table.insert(timedAttackListMaster, {self.text..": ", self.color, {} })
	for k,v in pairs(self.IDs) do
		EM:RegisterForEvent(sam.name..self.name..tostring(v), self.event, wrapper)
		EM:AddFilterForEvent(sam.name..self.name..tostring(v), self.event, REGISTER_FILTER_ABILITY_ID, v)
	end
end

function sam.TimerNotification:Unregister()
	EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
	for k,v in pairs(self.IDs) do
		EM:UnregisterForEvent(sam.name..self.name..tostring(v), self.event)
	end
	for k,v in pairs(sam.UI.activeAlerts) do
		v:SetHidden(true)
	end
	sam.UI.timedAlert:SetHidden(true)
	for k in pairs(timedAttackListMaster) do
		timedAttackListMaster[k] = nil
	end
end


-- ACTIVE ALERT OBJECT
sam.ActiveNotification = sam.Notification:Subclass()

-- for now, we will pass the appropriate handler function as a parameter for anything complex
function sam.ActiveNotification:New(customRegister, customUnregister, name, color, event, result, IDs, text, duration, targetPlayer)
	local alert = ZO_Object.New(self)
	alert:Initialize(customRegister, customUnregister, name, color, event, result, IDs, text, duration, targetPlayer)
	return alert
end

function sam.ActiveNotification:Initialize(customRegister, customUnregister, name, color, event, result, IDs, text, duration, targetPlayer)
	self:InitializeParent(name, color, event, result, IDs, text)
	--self.text = text
	self.duration = duration
	self.targetPlayer = targetPlayer -- true if we are only listening to direct player attacks
	--self.customHandler = customHandler 
	self.customRegister = customRegister -- for handling more complex alerts...
	self.customUnregister = customUnregister -- we just (un)register custom external handlers

	self.currentFrame = -1
	self.displaying = false
	self.alertCounter = 0
end

function sam.ActiveNotification:Handler(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	sam.debug("firing active handler for %s, result is %d", self.name, result)
	if self.targetPlayer and targetType ~= COMBAT_UNIT_TYPE_PLAYER then return end
	if result == self.result then
		self.alertCounter = self.alertCounter + 1
		if not self.displaying then -- don't double display a noti in case of fast-firing events
			self.currentFrame = sam.UI.getAvailableNotificationFrame()
			self.displaying = true
			local alertText = string.format("|c%s%s|r", self.color, self.text)
			sam.UI.displayAlert(self.currentFrame, alertText)
			--sam.UI.activeAlerts[self.currentFrame]:SetText(string.format("|c%s%s|r", self.color, self.text))
			--sam.UI.activeAlerts[self.currentFrame]:SetHidden(false)
		end
		PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)

		zo_callLater(function()
			self.alertCounter = self.alertCounter - 1
			if self.alertCounter <= 0 then
				self.alertCounter = 0
				--sam.UI.activeAlerts[self.currentFrame]:SetHidden(true)
				sam.UI.hideAlert(self.currentFrame)
				self.displaying = false
				self.currentFrame = -1
			end
		end, self.duration)
	end
end

function sam.ActiveNotification:Register()
	sam.debug("registering active alert with text: %s", self.text)
	if self.customRegister then
		self.customRegister()
	else
		local function wrapper(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
			self:Handler(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
		end
		for k,v in pairs(self.IDs) do
			EM:RegisterForEvent(sam.name..self.name..tostring(v), self.event, wrapper)
			EM:AddFilterForEvent(sam.name..self.name..tostring(v), self.event, REGISTER_FILTER_ABILITY_ID, v)
		end
	end
end

function sam.ActiveNotification:Unregister()
	if self.customUnregister then
		self.customUnregister()
	end
	EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
	for k,v in pairs(self.IDs) do
		EM:UnregisterForEvent(sam.name..self.name..tostring(v), self.event)
	end
	for k,v in pairs(sam.UI.activeAlerts) do
		v:SetHidden(true)
	end
	sam.UI.timedAlert:SetHidden(true)
	for k in pairs(timedAttackListMaster) do
		timedAttackListMaster[k] = nil
	end
	self.displaying = false
	self.currentFrame = -1
	self.alertCounter = 0
end

