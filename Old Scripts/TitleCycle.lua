-- Only for use with Lua_DoString(..)
function TitleCycle(time)
   dnum = 1;
   dtime = 0;
   dtime_arg = time;
   
   dtitleframe = CreateFrame("Frame");
   dtitleframe:SetScript("OnUpdate", TitleCycle_Timer);
end

function TitleCycle_Timer(self, elapsed) 
   dtime = dtime + elapsed;
   if dtime >= dtime_arg then    
      local t = {}; 
      for title = 1, GetNumTitles() - 1, 1 do 
         if IsTitleKnown(title) == 1 then 
            table.insert(t, title);
         end
      end 
      
      dnum = dnum + 1; 
      if dnum > #t then 
         dnum = 1;
      end 
      
      SetCurrentTitle(t[dnum]);
      dtime = 0;
   end
end

function TitleCycleStop()
   dtitleframe:SetScript("OnUpdate", function() end);
end
