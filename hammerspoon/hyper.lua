local status, hyperModeAppMappings = pcall(require, 'keyboard.hyper-apps')
spaces = require('hs._asm.undocumented.spaces') -- https://github.com/asmagill/hs._asm.undocumented.spaces

if not status then
  hyperModeAppMappings = require('keyboard.hyper-apps-defaults')
end

for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]
  hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, key, function()
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
