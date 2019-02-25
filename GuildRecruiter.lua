local n = GetNumWhoResults();
local i = 1; 
local x = 0;

if guildInvListSize == nil then
   guildInvList = {"Azurehide"};
   guildInvListSize = #guildInvList;
end


function addToSet(set, key)
   set[key] = true
end

function removeFromSet(set, key)
   set[key] = nil
end

function setContains(set, key)
   return set[key] ~= nil
end

while(i < n + 1) do 
   c, g = GetWhoInfo(i); 
   
   if (g == "") then 
      if (not setContains(guildInvList, c)) then
         GuildInvite(c);
         
         guildInvListSize = guildInvListSize + 1;
         addToSet(guildInvList, c);
         print('Invited: ' .. c);
         x = x + 1
      end
   end 
   
   i = i + 1; 
end

print('Invited ' .. x .. ' players to guild.') 

