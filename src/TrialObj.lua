SAMURAI = SAMURAI or { } -- get our namespace 
local sam = SAMURAI -- local version again

sam.MasterTrial = ZO_Object:Subclass() -- make our object

local var2 = "static var" -- equivalent to static in java and such

function sam.MasterTrial:New(objnum, var1) -- when called with a : functions silently pass 'self' as the first var
	local trial = ZO_Object.New(self) -- with a . you have to pass self manually
	trial:Initialize(objnum, var1)
	return trial
end

function sam.MasterTrial:Initialize(objnum, var1)
	self.localvar = var1

	local function getObjName(objnum) -- internal function, if declared outside as local it would be 'private'
		df("creating object %s", tostring(objnum)) -- df is equivalent to string.format
	end
	getObjName(objnum)
end

function sam.MasterTrial:printInfo()
	df("static var: %s, local var: %s", var2, self.localvar) -- can access static and object variables ezpz
end
