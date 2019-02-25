local f = CreateFrame('frame')

function shuffle(array)
   if not array then return nil end
   
   -- fisher-yates
   local output = { }
   local random = math.random
   
   for index = 1, #array do
      local offset = index - 1
      local value = array[index]
      local randomIndex = offset*random()
      local flooredIndex = randomIndex - randomIndex%1
      
      if flooredIndex == offset then
         output[#output + 1] = value
      else
         output[#output + 1] = output[flooredIndex + 1]
         output[flooredIndex + 1] = value
      end
   end
   
   return output
end

local function table_contains (tab, value)
   for _, v in ipairs(tab) do
      if value == v then
         return true
      end
   end
   
   return false
end

local function get_group_type()
   if not UnitInRaid('player') then
      return 'party'
   end
   
   return 'raid'
end

local function get_group_names()
   local group = get_group_type()
   local names = {}
   names[1] = UnitName('player')
   
   for i = 1, 40 do
      local name = UnitName(group .. i)
      if name and name ~= UnitName('player')  then
         table.insert(names, name)
      end
   end
   
   return names
end

local function get_existing_marks(names)
   local marks = {}
   for _, name in ipairs(names) do
      local mark = GetRaidTargetIndex(name) 
      if mark then 
         table.insert(marks, mark)
      end
   end
   
   return marks
end

local function range_difference(range, exclude)
   local result = {}
   
   for _, v in ipairs(range) do 
      if not table_contains(exclude, v) then
         table.insert(result, v)
      end
   end
   
   return result
end

local function iota(first, last) 
   local result = {}
   for i = first, last do
      table.insert(result, i)
   end
   
   return result
end

local function mark_party()
   local names = get_group_names()   
   local existing_marks = get_existing_marks(names)
   local marks = range_difference(iota(1, 8), existing_marks)
   marks = shuffle(marks)
   
   local mark_index = 1
   for _, name in ipairs(names) do
      if #marks == 0 then break end
      if not GetRaidTargetIndex(name) then
         SetRaidTarget(name, marks[mark_index])
         marks[mark_index] = nil
         mark_index = mark_index + 1
      end
   end
end

local function in_party()
   return GetNumPartyMembers() > 0
end

local function unmark_all()
   local group = get_group_type()
   for i = 1, 40 do
      SetRaidTarget(group .. i, 0)
   end
   
   SetRaidTarget('player', 0)
end

f:RegisterEvent('RAID_ROSTER_UPDATE')
f:RegisterEvent('PARTY_MEMBERS_CHANGED')
f:RegisterEvent('PLAYER_ENTERING_WORLD');
f:SetScript('OnEvent', function(self, event)
      --print(event)
      if in_party() and UnitIsPartyLeader('player') and not UnitInBattleground('player') then
         mark_party()
         
      elseif not in_party() then
         unmark_all()
      end
end) 
