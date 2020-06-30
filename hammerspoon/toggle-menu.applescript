tell application "System Preferences"
	reveal pane id "com.apple.preference.general"
end tell

tell application "System Events" to tell process "System Preferences" to tell window "General"
	click checkbox "Automatically hide and show the menu bar"
end tell

quit application "System Preferences"
