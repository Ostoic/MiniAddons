local message = "Yes Hello Welcome To The Horseolympics2013"

local subject = "Important Information"

local mailRoster = {}

function GetGuildRoster()
   count = 0
   
   for i = 1, GetNumGuildMembers() do
      name, rank, rI = GetGuildRosterInfo(i) 
      
      if rI < 8 then
         tinsert(mailRoster, name)
         count = count + 1
      end
   end
   
   print(string.format("Added %d mail recipients ", count))
end

function GuildMail()
   name = ""
   
   if #mailRoster > 0 then
      name = tremove(mailRoster, 1)
      SendMail(name, subject, message)
      print(string.format("Sent mail to %s", name))
   end
end