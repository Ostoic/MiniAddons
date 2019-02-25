Hack.Require 'lib: event'
Hack.Require 'lib: timer'

TriviaCheater = {}

function TriviaCheater.FindQuestionIndex(question)
   question = string.lower(question);
   
   for page = 1, 10 do 
      for i = 1, 200 do 
         if TriviaBot_Questions[page] and TriviaBot_Questions[page]['Question'] 
         and TriviaBot_Questions[page]['Question'][i] and string.lower(TriviaBot_Questions[page]['Question'][i]) == question then
            return page, i
         end
      end
   end
   
   return nil;
end

function TriviaCheater.GetAnswer(question)
   local page, index = TriviaCheater.FindQuestionIndex(question)
   if not page or not index then 
      return 
   end
   
   local answers = TriviaBot_Questions[page]['Answers'][index];
   if type(answers) == 'table' then
      return answers[1];
   end
   
   return answers;
end

function TriviaCheater.ParseQuestion(message)
   local pattern ='%[TriviaBot%]: Q: (.+)';
   return string.match(message, pattern);
end

local function ChatMsgListener(self, event, message)
   local question = TriviaCheater.ParseQuestion(message) 
   if not question then return end
   
   local answer = TriviaCheater.GetAnswer(question)
   if not answer then return end
   
   local chatType = nil;
   if event == 'CHAT_MSG_PARTY' then
      chatType = 'party'
      
   elseif event == 'CHAT_MSG_PARTY_LEADER' then
      chatType = 'party'
      
   elseif event == 'CHAT_MSG_RAID_LEADER' then
      chatType = 'raid'
      
   elseif event == 'CHAT_MSG_RAID' then
      chatType = 'raid'
      
   elseif event == 'CHAT_MSG_GUILD' then
      chatType = 'guild';
   end
   
   if not chatType then return end
   
   print(chatType);
   SendChatMessage(answer, chatType, nil, nil) 
end

AddEventListener('CHAT_MSG_PARTY', ChatMsgListener)
AddEventListener('CHAT_MSG_PARTY_LEADER', ChatMsgListener)
AddEventListener('CHAT_MSG_RAID', ChatMsgListener)
AddEventListener('CHAT_MSG_RAID_LEADER', ChatMsgListener)
AddEventListener('CHAT_MSG_GUILD', ChatMsgListener)

