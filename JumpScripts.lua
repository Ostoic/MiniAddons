Hack.Require 'lib: timer'

jmp = {}

local walk_toggled = false

jmp.actions = {
   check_landed,
}

function jmp.set_fps(fps)
   ConsoleExec('maxfps ' .. fps)
end

function jmp.max_fps()
   return tonumber(GetCVar('maxfps'))
end

hooksecurefunc('ToggleRun', 
   function()
      walk_toggled = not walk_toggled;
      if walk_toggled then
         print('walk toggled!')
      end
   end
)

-- Reset fps when we land
local function on_land()
   jmp.set_fps(60)
end

local was_falling = false

local function check_landed()
   if was_falling and not IsFalling() then
      on_land()
      was_falling = false
      
   else
      if IsFalling() then was_falling = true end
   end
end

local function execute_actions()
   for _, action in pairs(jmp.actions) do
      action()
   end
end

function jmp.default_fps_on_land()
   SetTimer( .1, check_landed, true)
   hooksecurefunc('JumpOrAscendStart', execute_actions)
end

-- 20 fps

function jmp.on_clip_jump()
   jmp.actions[2] = nil
   SetTimer( .4, 
      function()
         jmp.set_fps(20)
      end
   )
end

function jmp.clipping_fps_on_jump()
   jmp.actions[2] = jmp.on_clip_jump
end

function jmp.on_normal_jump()
   jmp.actions[2] = nil
   SetTimer( .4, 
      function()
         jmp.set_fps(60)
      end
   )
end

function jmp.normal_fps_on_jump()
   jmp.actions[2] = jmp.on_normal_jump
end

jmp.default_fps_on_land()

-- Make rotation frame
local frame = CreateFrame('Frame')

frame:SetParent(UIParent);
frame:SetWidth(120);
frame:SetHeight(42);
frame:SetPoint('top', UIParent);
frame:EnableMouse(true);
frame:SetMovable(true);

frame:RegisterForDrag('LeftButton');
frame:SetScript('OnDragStart', 
   function(self)
      self:StartMoving();
   end
)

frame:SetScript('OnDragStop', 
   function(self)
      self:StopMovingOrSizing()
   end
)

local font = frame:CreateFontString(nil, 'overlay', 'GameFontNormal');
font:SetPoint('center');

frame:SetScript('OnUpdate', 
   function()
      font:SetText('Facing: ' .. GetPlayerFacing())
   end
)

