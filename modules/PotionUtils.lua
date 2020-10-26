SAMURAI = SAMURAI or { }
local sam = SAMURAI

local function renameHeroism()
	local old = ZO_SharedInventoryManager.CreateOrUpdateSlotData
        ZO_SharedInventoryManager.CreateOrUpdateSlotData = function(self, existingSlotData, bagId, slotIndex, isNewItem)
                local slot, added = old(self, existingSlotData, bagId, slotIndex, isNewItem)
		if sam.savedVars.modules.potions.renameHeroism then
                	local link = GetItemLink(bagId, slotIndex)
                	local text, style, itemtype, id, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, data = ZO_LinkHandler_ParseLink(link)
                	if itemtype == "item" and id ~= "55262" and data then
                	        data = tonumber(data)
                	        local e1 = math.floor(data / 65536) % 256
                	        local e2 = math.floor(data / 256) % 256
                	        local e3 = data % 256
                	        if e1 == 31 or e2 == 31 or e3 == 31 then
                	                slot.displayQuality = 6
                	                slot.name = "Essence of Heroism"
                	                slot.rawName = "Essence of Heroism"
                	        end
                	end
		end
                return slot, added
        end
end

function sam.setupPotionModule()
	renameHeroism()
end
