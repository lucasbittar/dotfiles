-- App switching, bound on each Mac instead of in Karabiner.
-- Karabiner's shell_command runs on the Mac the keyboard is attached to, so under
-- Universal Control it switched apps on the iMac even with the pointer on the
-- MacBook. Plain keys are forwarded, so whichever Mac has the pointer handles them.
-- Old Karabiner rules: karabiner/backup/app-switch-rules.json
local apps = {
  ["1"] = "Ghostty",
  ["2"] = "Google Chrome",
  ["3"] = "Slack",
  ["4"] = "Notion",
}

for key, app in pairs(apps) do
  hs.hotkey.bind({ "ctrl" }, key, function() hs.application.launchOrFocus(app) end)
end

hs.autoLaunch(true)
