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

-- macOS refuses keys it has reserved (Ctrl+1 is held by the "Switch to Desktop 1"
-- shortcut even while it is disabled); catch those with an event tap instead.
-- The tap needs Accessibility permission.
local tapped = {}

for key, app in pairs(apps) do
  local hotkey = hs.hotkey.new({ "ctrl" }, key, function() hs.application.launchOrFocus(app) end)
  if not hotkey:enable() then
    tapped[key] = app
  end
end

if next(tapped) then
  -- global so the tap isn't garbage collected
  appSwitchTap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
    local app = tapped[hs.keycodes.map[event:getKeyCode()]]
    if app and event:getFlags():containExactly({ "ctrl" }) then
      hs.application.launchOrFocus(app)
      return true
    end
    return false
  end):start()
end

hs.autoLaunch(true)
