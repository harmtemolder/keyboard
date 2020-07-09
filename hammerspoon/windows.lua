hs.window.animationDuration = 0.5 -- in seconds, set to 0 for no animation
windowPadding = 6 -- in pixels, set to 0 for no padding

function hs.window.fullScreen(win)
  if win ~= nil then
      win:setFullScreen(not win:isFullScreen())
  end
end


-- +-----------------+
-- |                 |
-- |      HERE       |
-- |                 |
-- +-----------------+
function hs.window.maximizeWithPadding(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w - 2 * windowPadding
  f.h = max.h - 2 * windowPadding
  f.x = max.x + windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = max.h - 2 * windowPadding
  f.x = max.x + windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = max.h - 2 * windowPadding
  f.x = max.x + f.w + 2 * windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w - 2 * windowPadding
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = max.w - 2 * windowPadding
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + windowPadding
  f.y = max.y + f.h + 2 * windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + windowPadding
  f.y = max.y + f.h + 2 * windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + f.w + 2 * windowPadding
  f.y = max.y + f.h + 2 * windowPadding

  win:setFrame(f)
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) / 2
  f.h = (max.h - 3 * windowPadding) / 2
  f.x = max.x + f.w + 2 * windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +--------------+
-- |  +--------+  |
-- |  |  HERE  |  |
-- |  +--------+  |
-- +---------------+
function hs.window.centerCurrentSize(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.w / 2 - f.w / 2
  f.y = max.h / 2 - f.h / 2
  win:setFrame(f)
end

-- +-----------------+
-- |      |          |
-- | HERE |          |
-- |      |          |
-- +-----------------+
function hs.window.left40(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) * 0.4
  f.h = max.h - 2 * windowPadding
  f.x = max.x + windowPadding
  f.y = max.y + windowPadding
  win:setFrame(f)
end

-- +-----------------+
-- |      |          |
-- |      |   HERE   |
-- |      |          |
-- +-----------------+
function hs.window.right60(win)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.w = (max.w - 3 * windowPadding) * 0.6
  f.h = max.h - 2 * windowPadding
  f.x = max.x + ((max.w - 3 * windowPadding) * 0.4) + (2 * windowPadding)
  f.y = max.y + windowPadding
  win:setFrame(f)
end

function hs.window.nextScreen(win)
  local currentScreen = win:screen()
  local allScreens = hs.screen.allScreens()
  currentScreenIndex = hs.fnutils.indexOf(allScreens, currentScreen)
  nextScreenIndex = currentScreenIndex + 1

  if allScreens[nextScreenIndex] then
    win:moveToScreen(allScreens[nextScreenIndex])
  else
    win:moveToScreen(allScreens[1])
  end
end

windowLayoutMode = hs.hotkey.modal.new({}, 'f20')

windowLayoutMode.entered = function()
  windowLayoutMode.statusMessage:show()
end

windowLayoutMode.exited = function()
  windowLayoutMode.statusMessage:hide()
end

-- Bind the given key to call the given function and exit WindowLayout mode
function windowLayoutMode.bindWithAutomaticExit(mode, modifiers, key, fn)
  mode:bind(modifiers, key, function()
    mode:exit()
    fn()
  end)
end

local status, windowMappings = pcall(require, 'keyboard.windows-bindings')

if not status then
  windowMappings = require('keyboard.windows-bindings-defaults')
end

local modifiers = windowMappings.modifiers
local showHelp  = windowMappings.showHelp
local trigger   = windowMappings.trigger
local mappings  = windowMappings.mappings

function getModifiersStr(modifiers)
  local modMap = { shift = '⇧', ctrl = '⌃', alt = '⌥', cmd = '⌘' }
  local retVal = ''

  for i, v in ipairs(modifiers) do
    retVal = retVal .. modMap[v]
  end

  return retVal
end

local msgStr = 'Window Layout Mode (Vim Mode > `s`)'

for i, mapping in ipairs(mappings) do
  local modifiers, trigger, winFunction = table.unpack(mapping)
  local hotKeyStr = getModifiersStr(modifiers)

  if showHelp == true then
    if string.len(hotKeyStr) > 0 then
      msgStr = msgStr .. (string.format('\n%10s+%s => %s', hotKeyStr, trigger, winFunction))
    else
      msgStr = msgStr .. (string.format('\n%11s => %s', trigger, winFunction))
    end
  end

  windowLayoutMode:bindWithAutomaticExit(modifiers, trigger, function()
    --example: hs.window.focusedWindow():upRight()
    local fw = hs.window.focusedWindow()
    fw[winFunction](fw)
  end)
end

msgStr = msgStr .. '\n`s` again to cancel'

local message = require('keyboard.status-message')
windowLayoutMode.statusMessage = message.new(msgStr)

-- Use Vim Mode > `s` to enter Window Mode, `s` again to exit
hs.hotkey.bind(modifiers, trigger, function()
  windowLayoutMode:enter()
end)

windowLayoutMode:bind({}, 's', function()
  windowLayoutMode:exit()
end)
