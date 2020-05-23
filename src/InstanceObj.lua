SAMURAI = SAMURAI or { } -- get our namespace 
local sam = SAMURAI -- local version again

sam.Instance = ZO_Object:Subclass() -- make our object


function sam.Instance:New(zoneID, startCombat, reset) -- when called with a : functions silently pass 'self' as the first var
	local instance = ZO_Object.New(self) -- with a . you have to pass self manually
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
	for k,v in pairs(self.alerts) do
		v:Unregister()
	end
end

