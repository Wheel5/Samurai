SAMURAI = SAMURAI or { }
local sam = SAMURAI
local EM = GetEventManager()
local strformat = string.format

local timedAttackListMaster = { }
-- will be filled with sublists with the format:
-- { "attack name: ", "color", { table of attack timers } }
-- innermost table will be updated with times
-- attack table with be added or removed on registration

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
		return table.concat(countdownListFormatted, ", ")
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

function sam.Notification:InitializeParent(name, color, event, IDs)
	self.name = name
	self.color = color
	self.event = event
	self.IDs = IDs
	
end

--function sam.Notification:Unregister()
--	EM:UnregisterForEvent(sam.name..self.name, self.event)
--end


-- TIMED ALERT OBJECT
sam.TimerNotification = sam.Notification:Subclass()

function sam.TimerNotification:New(name, color, event, IDs)
	local timer = ZO_Object.New(self)
	timer:Initialize(name, color, event, IDs)
	return timer
end

function sam.TimerNotification:Initialize(name, color, event, IDs)
	self:InitializeParent(name, color, event, IDs)
end

function sam.TimerNotification:Handler(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)
	if targetType ~= COMBAT_UNIT_TYPE_PLAYER or hitValue < 100 then return end

	if result == ACTION_RESULT_BEGIN then
		for k,v in ipairs(timedAttackListMaster) do
			if string.find(v[1], self.name) then
				table.insert(v[3], GetGameTimeMilliseconds() + hitValue)
			end
		end
		timedAttackCounter()
		sam.UI.timedAlert:SetHidden(false)
		--PlaySound(SOUNDS.CHAMPION_POINTS_COMMITTED)

		EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
		EM:RegisterForUpdate(sam.name.."TimedAttackCountdown", 100, timedAttackCounter)
	end
end

function sam.TimerNotification:Register()
	table.insert(timedAttackListMaster, {self.name..": ", self.color, {} })
	EM:RegisterForEvent(sam.name..self.name, self.event, self.Handler)
	EM:AddFilterForEvent(sam.name..self.name, self.event, REGISTER_FILTER_ABILITY_ID, self.IDs[1])
end

function sam.TimerNotification:Unregister()
	EM:UnregisterForEvent(sam.name..self.name, self.event) -- do for all IDs
	EM:UnregisterForUpdate(sam.name.."TimedAttackCountdown")
	sam.UI.timedAlert:SetHidden(true)
	for k in pairs(timedAttackListMaster) do
		timedAttackListMaster[k] = nil
	end
end

