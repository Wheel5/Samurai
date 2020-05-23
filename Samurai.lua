SAMURAI = SAMURAI or { } -- global namespace
local sam = SAMURAI -- local copy for efficiency

local EM = GetEventManager() -- local copy of event manager

sam.name = "Samurai"
sam.version = "1.0"

sam.debug = false

sam.LUNITS = LibUnits2

sam.defaults = { } -- used for saved vars eventually

sam.instances = { }

function sam.debug(message, ...)
	if not sam.debug then return end
	df("[Samurai]: %s", message:format(...))
end

--function sam.testObjects()
--	local obj1 = sam.MasterTrial:New("obj1", "localvar1") -- create 2 objects with different values
--	local obj2 = sam.MasterTrial:New("obj2", "localvar2")
--	local testList = { obj1, obj2 } -- place objects in table to iterate over
--	
--	for _,o in pairs(testList) do -- polymorphism!
--		o:printInfo()
--	end
--end

local function slash(args)
	if args == "debug 1" then
		sam.debug = true
	elseif args == "debug 0" then
		sam.debug = false
	end
end

function sam.playerActivated()
	local zoneID = GetZoneId(GetUnitZoneIndex("player"))
	sam.generalAlerts:Register()
	for k,v in pairs(sam.instances) do
		if v:GetZoneId() == zoneID then
			v:Register()
		else
			v:Unregister()
		end
	end
end

function sam.init(e, addon)
	if addon ~= sam.name then return end -- make sure we're loading this addon
	EM:UnregisterForEvent(sam.name.."Load", EVENT_ADD_ON_LOADED) -- we're loaded, unregister
	--SLASH_COMMANDS["/samurai"] = sam.testObjects -- register slash command for the test function
	sam.buildDisplay()
	--SLASH_COMMANDS["/spawnframetest"] = sam.UI.getAvailableNotificationFrame
	sam.buildMenu()
	sam.setupTestHarness()
	EM:RegisterForEvent(sam.name.."playerActivate", EVENT_PLAYER_ACTIVATED, sam.playerActivated)
end

-- register addon load
EM:RegisterForEvent(sam.name.."Load", EVENT_ADD_ON_LOADED, sam.init)

