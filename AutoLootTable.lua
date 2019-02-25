ali = ali or {}

ali.loot_table = {
   "Frostweave Cloth",
   "Crystallized",
   "Runic Healing Potion",
   "Runic Mana Potion",
   "Potion of Speed",
   "Super ",
   "Imbued Horde Armor",
   "Netherweave",
}

local function item_price(name)
   itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType,
   itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice =
   GetItemInfo(name)
   return itemSellPrice
end


local function string_contains_table(text, table)
   for _, e in ipairs(table) do
      if string.find(text, e, 1, true) then 
         return true 
      end
   end
   
   return false
end


function ali.check_loot_items()
   local loot_items = {}
   
   if LootSlotIsCoin(1) then 
      table.insert(loot_items, 1)
   end
   
   for i = 1, GetNumLootItems() do 
      local _, item_name = GetLootSlotInfo(i)
      local item_link = GetLootSlotLink(i)
      
      if item_name and string_contains_table(item_name, ali.loot_table) then
         table.insert(loot_items, i)
      end
      
      if item_link and item_price(item_link) / 10000 > 1 then 
         table.insert(loot_items, i)
      end
   end
   
   for _, i in ipairs(loot_items) do
      LootSlot(i)
   end
end

if not ali.frame then 
   ali.frame = CreateFrame("Frame")
   ali.frame:RegisterEvent("LOOT_OPENED")
   ali.frame:SetScript("OnEvent", 
      function(self, event)
         if event == "LOOT_OPENED" then
            ali.check_loot_items()
         end
      end
   )
end

function ali.new_item(name)
   if name == nil then return end
   
   for _, v in ipairs(ali.loot_table) do 
      if v == name then 
         return 
      end
   end
   
   table.insert(ali.loot_table, name)
   print("Autolooting: " .. name)
end

