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

	local generalOptions = {
		{
			type = "divider",
		},
		{
			type = "description",
			text = "don't be shit",
		},
		{
			type = "header",
			name = "General Display Options",
		},
		{
			type = "checkbox",
			name = "Lock Frames",
			tooltip = "Unlock to position frames in desired location",
			getFunc = function() return lockUI end,
			setFunc = function(value)
				sam.UI.setHudDisplay(value)
				lockUI = value
			end,
		},
	}

	LAM:RegisterOptionControls(sam.name.."GeneralOptions", generalOptions)
end
