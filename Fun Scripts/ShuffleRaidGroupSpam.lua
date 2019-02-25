if g_raidGroupFrame == nil then
   g_raidGroupFrame = CreateFrame("Frame")
   g_raidGroupFrame:SetScript("OnUpdate", function()
         for i = 1, 40 do
            SetRaidSubgroup(i, random(8))
         end 
      end
   )
else
   g_raidGroupFrame:SetScript("OnUpdate", function() end)
   g_raidGroupFrame = nil
end

-- CreateFrame("Frame"):SetScript("OnUpdate", function() SetRaidTarget("player", random(8)) end)