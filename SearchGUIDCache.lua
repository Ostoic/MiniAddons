function countHexDigits(num)
   if num == 0 then return 1 end;
   if num == 1 then return 1 end;
   local count = 0;
   
   num = abs(num);
   
   while num > 1 do
      num = num / 16;
      count = count + 1;
   end
   
   return count;
end

function Dec2Hex(nValue)
   if type(nValue) == "string" then
      nValue = tonumber(nValue);
   end
   nHexVal = string.format("%X", nValue);  -- %X returns uppercase hex, %x gives lowercase letters
   sHexVal = nHexVal.."";
   for i = 1, (8 - countHexDigits(nValue)) do
      sHexVal = '0' .. sHexVal
   end
   
   return sHexVal;
end

function GetGUIDByName(name)
   local high = '0x07000000';
   
   for low = 0000000, 3500000 do
      local className, classId, raceName, raceId, gender, fName, realm = GetPlayerInfoByGUID(high .. Dec2Hex(low))
      
      if fName == name then 
         return high .. Dec2Hex(low), low
      end
   end
   
   return nil
end

