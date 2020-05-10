-- Default keybindings for launching apps in Hyper Mode

function volMute()
  hs.audiodevice.defaultOutputDevice():setOutputMuted(true)
  hs.alert.closeAll()
  hs.alert.show("🔇")
end

function volUnmute()
  hs.audiodevice.defaultOutputDevice():setOutputMuted(false)
  hs.alert.closeAll()
  hs.alert.show("🔈 (" .. string.format("%.0f", hs.audiodevice.defaultOutputDevice():volume()) .. ")")
  hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
end

function volMuteToggle()
  if hs.audiodevice.defaultOutputDevice():outputMuted() then
    volUnmute()
  else
    volMute()
  end
end

function volDown()
  if hs.audiodevice.defaultOutputDevice():volume() <= 10 then
    hs.audiodevice.defaultOutputDevice():setOutputMuted(true)
    hs.alert.closeAll()
    hs.alert.show("🔇")
  else
    hs.audiodevice.defaultOutputDevice():setVolume(math.max(hs.audiodevice.defaultOutputDevice():volume() - 10, 0))
    hs.alert.closeAll()
    hs.alert.show("🔉 (" .. string.format("%.0f", hs.audiodevice.defaultOutputDevice():volume()) .. ")")
    hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
  end
end

function volUp()
  if hs.audiodevice.defaultOutputDevice():outputMuted() then
    hs.audiodevice.defaultOutputDevice():setVolume(10)
    hs.audiodevice.defaultOutputDevice():setOutputMuted(false)
    hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
  else
    hs.audiodevice.defaultOutputDevice():setVolume(math.min(hs.audiodevice.defaultOutputDevice():volume() + 10, 100))
    hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
  end
  hs.alert.closeAll()
  hs.alert.show("🔊 (" .. string.format("%.0f", hs.audiodevice.defaultOutputDevice():volume()) .. ")")
end

function moveSpace(direction)
  -- Note that the spaces module is loaded in hyper.lua
  local currentSpace = spaces.activeSpace()
  local screenSpaces = spaces.layout()[spaces.mainScreenUUID()]
  local currentSpaceIndex = hs.fnutils.indexOf(screenSpaces, currentSpace) or 1
  local targetSpaceIndex = direction == 'west' and currentSpaceIndex - 1 or currentSpaceIndex + 1
  local targetSpace = screenSpaces[targetSpaceIndex]
  hs.window.frontmostWindow():spacesMoveTo(targetSpace)
  spaces.changeToSpace(targetSpace)
end

function moveSpaceWest()
  moveSpace('west')
end

function moveSpaceEast()
  moveSpace('east')
end

-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.
return {
  -- Numbers 1, 2, 3 and 4 are mapped to the corresponding spaces
  { 'a', 'Atom' },              -- "A" for "Atom"
  { 'c', 'Google Chrome' },     -- "C" for "Chrome"
  { 'f', 'Firefox' },           -- "F" for "Firefox"
  { 'g', 'GitHub Desktop' },    -- "G" for "GitHub"
  { 'm', 'Mail' },              -- "M" for "Mail"
  { 'p', 'Color Picker' },      -- "P" for "Picker"
  -- I have set Mac's keyboard shortcut for screenshots to hyper+s
  { 't', 'iTerm' },             -- "T" for "Terminal"
  { 'F10', volMuteToggle },     -- Also enable these fn keys with hyper key
  { 'F11', volDown },           -- Also enable these fn keys with hyper key
  { 'F12', volUp },             -- Also enable these fn keys with hyper key
  { '[', moveSpaceWest },       -- Moves the active window one space west with ,
  { ']', moveSpaceEast },       -- Moves the active window one space east with .
}
