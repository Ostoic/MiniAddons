
for i = 1, GetNumChannelMembers(7) do
   c = GetChannelRosterInfo(7, i) 
   
   InviteUnit(c);
   ---GuildInvite(c);
   print('Talked to: ' .. c);
end
