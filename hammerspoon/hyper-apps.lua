-- Default keybindings for launching apps in Hyper Mode

function volMuteToggle()
  if hs.audiodevice.defaultOutputDevice():outputMuted() then
    hs.audiodevice.defaultOutputDevice():setOutputMuted(false)
    hs.alert.closeAll()
    hs.alert.show("🔈 (" .. string.format("%.0f", hs.audiodevice.defaultOutputDevice():volume()) .. ")")
    hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
  else
    hs.audiodevice.defaultOutputDevice():setOutputMuted(true)
    hs.alert.closeAll()
    hs.alert.show("🔇")
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
    hs.sound.getByName("Tink"):play()
  else
    hs.audiodevice.defaultOutputDevice():setVolume(math.min(hs.audiodevice.defaultOutputDevice():volume() + 10, 100))
    hs.sound.getByFile("/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"):play()
  end
  hs.alert.closeAll()
  hs.alert.show("🔊 (" .. string.format("%.0f", hs.audiodevice.defaultOutputDevice():volume()) .. ")")
end

-- To launch _your_ most commonly-used apps via Hyper Mode, create a copy of
-- this file, save it as `hyper-apps.lua`, and edit the table below to configure
-- your preferred shortcuts.
return {
  { 'a', 'Atom' },              -- "A" for "Atom"
  { 'b', 'Board Game Arena' },  -- "B" for "Board Game Arena"
  { 'c', 'Google Chrome' },     -- "C" for "Chrome"
  { 'd', 'Dominion' },          -- "D" for "Dominion"
  { 'f', 'Finder' },            -- "F" for "Finder"
  { 'g', 'GitHub Desktop' },    -- "G" for "GitHub"
  { 'm', 'Mail' },              -- "M" for "Mail"
  { 'o', 'OpenEmu' },           -- "O" for "OpenEmu"
  { 'p', 'Color Picker' },      -- "P" for "Picker"
  { 's', 'Steam' },             -- "S" for "Steam"
  { 't', 'iTerm' },             -- "T" for "Terminal"
  { 'v', 'Surfshark' },         -- "V" for "VPN"
  { 'w', 'Firefox' },           -- "W" for "Web"
  { 'F10', volMuteToggle },     -- Also enable these fn keys with hyper key
  { 'F11', volDown },           -- Also enable these fn keys with hyper key
  { 'F12', volUp },             -- Also enable these fn keys with hyper key
}
