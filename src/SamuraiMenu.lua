SAMURAI = SAMURAI or { }
local sam = SAMURAI

function sam.buildMenu()
	local LAM = LibAddonMenu2
	local lockUI = true
	
	local panelData = {
		type = "panel",
		name = sam.name,
		displayName = "|cffd000Samur|r.|cffe675ai|r",
		author = "|cc2ff19Wheels|r, |cef42ffMormo|r",
		version = ""..sam.version,
		registerForRefresh = true,
	}

	LAM:RegisterAddonPanel(sam.name.."GeneralOptions", panelData)

	local generalNotis = {
		{
			type = "description",
			text = "Alerts available in all locations",
		},
		{
			type = "divider",
		},
		{
			type = "checkbox",
			name = "Taking Aim",
			tooltip = "Archer taking aim alert",
			width = "half",
			getFunc = function() return sam.savedVars.notis.TakingAim end,
			setFunc = function(value) sam.savedVars.notis.TakingAim = value end,
		},
		{
			type = "checkbox",
			name = "Heavy Attack",
			tooltip = "General heavy attack notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.HeavyAttack end,
			setFunc = function(value) sam.savedVars.notis.HeavyAttack = value end,
		},
		{
			type = "checkbox",
			name = "Heavy Slash",
			tooltip = "General heavy slash notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.HeavySlash end,
			setFunc = function(value) sam.savedVars.notis.HeavySlash = value end,
		},
		{
			type = "checkbox",
			name = "Heavy Strike",
			tooltip = "General heavy strike notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.HeavyStrike end,
			setFunc = function(value) sam.savedVars.notis.HeavyStrike = value end,
		},
		{
			type = "checkbox",
			name = "Bash",
			tooltip = "General bash attack notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Bash end,
			setFunc = function(value) sam.savedVars.notis.Bash = value end,
		},
		{
			type = "checkbox",
			name = "Uppercut",
			tooltip = "General uppercut notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.UpperCut end,
			setFunc = function(value) sam.savedVars.notis.UpperCut = value end,
		},
		{
			type = "checkbox",
			name = "Anvil Cracker",
			tooltip = "General anvil cracker notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.AnvilCracker end,
			setFunc = function(value) sam.savedVars.notis.AnvilCracker = value end,
		},
		{
			type = "checkbox",
			name = "Crushing Blow",
			tooltip = "General crushing blow notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.CrushingBlow end,
			setFunc = function(value) sam.savedVars.notis.CrushingBlow = value end,
		},
		{
			type = "checkbox",
			name = "Boulder",
			tooltip = "General boulder notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Boulder end,
			setFunc = function(value) sam.savedVars.notis.Boulder = value end,
		},
		{
			type = "checkbox",
			name = "Slam",
			tooltip = "General slam notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Slam end,
			setFunc = function(value) sam.savedVars.notis.Slam = value end,
		},
		{
			type = "checkbox",
			name = "Power Bash",
			tooltip = "General power bash notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.powerBash end,
			setFunc = function(value) sam.savedVars.notis.powerBash = value end,
		},
		{
			type = "checkbox",
			name = "Lava Whip",
			tooltip = "General lava whip notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.LavaWhip end,
			setFunc = function(value) sam.savedVars.notis.LavaWhip = value end,
		},
		{
			type = "checkbox",
			name = "Toppling Blow",
			tooltip = "General toppling blow notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.TopplingBlow end,
			setFunc = function(value) sam.savedVars.notis.TopplingBlow = value end,
		},
		{
			type = "checkbox",
			name = "Clash of Bones",
			tooltip = "General clash of bones notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.ClashofBones end,
			setFunc = function(value) sam.savedVars.notis.ClashofBones = value end,
		},
		{
			type = "checkbox",
			name = "Drain Resource",
			tooltip = "General drain resource notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.DrainResource end,
			setFunc = function(value) sam.savedVars.notis.DrainResource = value end,
		},
		{
			type = "checkbox",
			name = "Lava Geyser",
			tooltip = "General lava geyser notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.LavaGeyser end,
			setFunc = function(value) sam.savedVars.notis.LavaGeyser = value end,
		},
		{
			type = "checkbox",
			name = "Rake",
			tooltip = "General hackwing rake notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Rake end,
			setFunc = function(value) sam.savedVars.notis.Rake = value end,
		},
	}

	local blackroseNotis = {
		{
			type = "description",
			text = "Alerts available in Blackrose Prison",
		},
		{
			type = "divider",
		},
		{
			type = "checkbox",
			name = "Dive",
			tooltip = "Hackwing dive notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Dive end,
			setFunc = function(value) sam.savedVars.notis.Dive = value end,
		},
	}

	local kynesNotis = {
		{
			type = "description",
			text = "Alerts available in Kyne's Aegis",
		},
		{
			type = "divider",
		},
		{
			type = "checkbox",
			name = "Wrath of Tides",
			tooltip = "Wrath of tides notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.WrathofTides end,
			setFunc = function(value) sam.savedVars.notis.WrathofTides = value end,
		},
		{
			type = "checkbox",
			name = "Crashing Wave",
			tooltip = "Crashing wave notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.CrashingWave end,
			setFunc = function(value) sam.savedVars.notis.CrashingWave = value end,
		},
	}

	local cloudrestNotis = {
		{
			type = "description",
			text = "Alerts available in Cloudrest",
		},
		{
			type = "divider",
		},
		{
			type = "checkbox",
			name = "Shocking Smash",
			tooltip = "Shocking smash notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.ShockingSmash end,
			setFunc = function(value) sam.savedVars.notis.ShockingSmash = value end,
		},
		{
			type = "checkbox",
			name = "Direct Current",
			tooltip = "Direct current notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.DirectCurrent end,
			setFunc = function(value) sam.savedVars.notis.DirectCurrent = value end,
		},
		{
			type = "checkbox",
			name = "Nocturnal's Favor",
			tooltip = "Nocturnal's favor (HA) notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.NocturnalsFavor end,
			setFunc = function(value) sam.savedVars.notis.NocturnalsFavor = value end,
		},
		{
			type = "checkbox",
			name = "Creeper Spawn",
			tooltip = "Creeper spawn notification",
			width = "half",
			getFunc = function() return sam.savedVars.notis.Creeper end,
			setFunc = function(value) sam.savedVars.notis.Creeper = value end,
		},
	}

	local generalOptions = {
		{
			type = "divider",
		},
		{
			type = "description",
			text = "additional settings to be added",
		},
		{
			type = "header",
			name = "General Display Options",
		},
		--{
		--	type = "checkbox",
		--	name = "Lock Frames",
		--	tooltip = "Unlock to position frames in desired location",
		--	disabled = true,
		--	getFunc = function() return lockUI end,
		--	setFunc = function(value)
		--		sam.UI.setHudDisplay(value)
		--		lockUI = value
		--	end,
		--},
		{
			type = "divider",
		},
		{
			type = "header",
			name = "Notifications",
		},
		{
			type = "submenu",
			name = "General",
			controls = generalNotis,
		},
		{
			type = "submenu",
			name = "Kynes Aegis",
			controls = kynesNotis,
		},
		{
			type = "submenu",
			name = "Cloudrest",
			controls = cloudrestNotis,
		},
		{
			type = "submenu",
			name = "Blackrose Prison",
			controls = blackroseNotis,
		},
	}

	LAM:RegisterOptionControls(sam.name.."GeneralOptions", generalOptions)
end
