SAMURAI = SAMURAI or { }
local sam = SAMURAI

local EM = GetEventManager()

sam.name = "Samurai"
sam.version = "1.1"

sam.dbug = false

sam.LUNITS = LibUnits2

sam.defaults = {
	["debug"] = false,
	["notis"] = {
		["Dive"] = true,
		["TakingAim"] = true,
		["HeavyAttack"] = true,
		["HeavySlash"] = true,
		["Bash"] = true,
		["UpperCut"] = true,
		["AnvilCracker"] = true,
		["CrushingBlow"] = true,
		["Boulder"] = true,
		["Slam"] = true,
		["powerBash"] = true,
		["LavaWhip"] = true,
		["TopplingBlow"] = true,
		["ClashofBones"] = true,
		["DrainResource"] = true,
		["LavaGeyser"] = true,
		["Rake"] = true, 
		["WrathofTides"] = true, 
		["CrashingWave"] = true, 
		["ShockingSmash"] = true,
		["DirectCurrent"] = true,
		["NocturnalsFavor"] = true,
		["Creeper"] = true,
		["HeavyStrike"] = true,
		["kaMeteor"] = true,
	},
}

sam.instances = { }

function sam.debug(message, ...)
	if not sam.dbug then return end
	df("[|cffd000Samur|r.|cffe675ai|r] %s", message:format(...))
end

local function slash(args)
	if args == "debug 1" then
		sam.dbug = true
		sam.savedVars.debug = true
		sam.debug("|c00FF00enabling|r debug mode")
	elseif args == "debug 0" then
		sam.debug("|cFF0000disabling|r debug mode")
		sam.dbug = false
		sam.savedVars.debug = false
	elseif args == "master" then
		sam.masterPrint()
	end
end

function sam.playerActivated()
	local zoneID = GetZoneId(GetUnitZoneIndex("player"))
	for k,v in pairs(sam.instances) do
		if v:getZoneID() == zoneID then
			sam.debug("loading zone %d", zoneID)
			v:Register()
		else
			v:Unregister()
		end
	end
end

function sam.init(e, addon)
	if addon ~= sam.name then return end
	EM:UnregisterForEvent(sam.name.."Load", EVENT_ADD_ON_LOADED)
	sam.savedVars = ZO_SavedVars:NewCharacterIdSettings("SamuraiSavedVars", 1, "Samurai", sam.defaults, GetWorldName())
	sam.dbug = sam.savedVars.debug
	SLASH_COMMANDS["/samurai"] = slash
	sam.buildDisplay()
	sam.buildMenu()
	sam.setupTestHarness()
	sam.onStartupNotificationSetup()
	EM:RegisterForEvent(sam.name.."playerActivate", EVENT_PLAYER_ACTIVATED, sam.playerActivated)
	sam.generalAlerts:Register()
end

EM:RegisterForEvent(sam.name.."Load", EVENT_ADD_ON_LOADED, sam.init)

