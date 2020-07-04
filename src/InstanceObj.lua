SAMURAI = SAMURAI or { }
local sam = SAMURAI

sam.Instance = ZO_Object:Subclass()


function sam.Instance:New(zoneID, startCombat, reset)
	local instance = ZO_Object.New(self)
	instance:Initialize(zoneID)
	return instance
end

function sam.Instance:Initialize(zoneID, startCombat, reset)
	self.zoneID = zoneID
	self.alerts = { }
	self.startCombat = StartCombat
	self.reset = reset
	self.loaded = false
end

function sam.Instance:getZoneID()
	return self.zoneID
end

function sam.Instance:Reset()
      	if self.reset then self.reset() end
end

function sam.Instance:StartCombat()
      	if self.startCombat then self.startCombat() end
end

function sam.Instance:AddAlert(alertObj)
	table.insert(self.alerts, alertObj)
end

function sam.Instance:Register()
	if self.loaded then return end -- don't double load
	for k,v in pairs(self.alerts) do
		v:Register()
	end
	self.loaded = true
end

function sam.Instance:Unregister()
	if not self.loaded then return end -- only unregister if we have already registered for this instance
	sam.debug("unloading zone %d", self.zoneID)
	for k,v in pairs(self.alerts) do
		v:Unregister()
	end
	self.loaded = false
end

