-- local status, hyperModeAppMappings = pcall(require, 'keyboard.hyper-apps')
-- spaces = require('hs._asm.undocumented.spaces') -- https://github.com/asmagill/hs._asm.undocumented.spaces
--
-- if not status then
--   hyperModeAppMappings = require('keyboard.hyper-apps-defaults')
-- end

-- for i, mapping in ipairs(hyperModeAppMappings) do
--   local key = mapping[1]
--   local app = mapping[2]
--   hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, key, function()
--     if (type(app) == 'string') then
--       local appSpace = hs.application.open(app):mainWindow():spaces()[1]
--       if spaces.activeSpace() ~= appSpace then
--         spaces.changeToSpace(appSpace)
--       end
--     elseif (type(app) == 'function') then
--       app()
--     else
--       hs.logger.new('hyper'):e('Invalid mapping for Hyper +', key)
--     end
--   end)
-- end

hyperMode = hs.hotkey.modal.new({}, 'f18')

hyperMode.entered = function()
  hyperMode.statusMessage:show()
end

hyperMode.exited = function()
  hyperMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit Hyper Mode
function hyperMode.bindWithAutomaticExit(mode, key, fn)
  mode:bind({}, key, function()
    mode:exit()
    fn()
  end)
end

local status, hyperApps = pcall(require, 'keyboard.hyper-apps')

if not status then
  hyperApps = require('keyboard.hyper-apps-defaults')
end

local msgStr = 'Hyper Mode (Vim Mode > `space`)'

for i, mapping in ipairs(hyperApps) do
  local trigger, app, name = table.unpack(mapping)

  msgStr = msgStr .. (string.format('\n%11s => %s', trigger, name))

  hyperMode:bindWithAutomaticExit(trigger, function()
    if (type(app) == 'string') then
      local appSpace = hs.application.open(app):mainWindow():spaces()[1]
      if spaces.activeSpace() ~= appSpace then
        spaces.changeToSpace(appSpace)
      end
    elseif (type(app) == 'function') then
      app()
    else
      hs.logger.new('hyper'):e('Invalid mapping for Hyper +', key)
    end
  end)
end

msgStr = msgStr .. '\n`space` again to cancel'

local message = require('keyboard.status-message')
hyperMode.statusMessage = message.new(msgStr)

-- Use Vim Mode > `space` to enter Hyper Mode, `space` again to exit
hs.hotkey.bind({}, 'f18', function()
  hyperMode:enter()
end)

hyperMode:bind({}, 'space', function()
  hyperMode:exit()
end)
