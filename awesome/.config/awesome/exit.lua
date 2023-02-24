local spawn = require("awful.spawn")
local naughty = require("naughty")

local icon_path = os.getenv("HOME") .. "/.config/awesome/images/power.png"

local state = { cid = nil }

local lock_command = '$HOME/.local/bin/fancy-lock && sleep 1 && '
local lock = { "Lock", lock_command }
local shutdown = { "Shut down", "shutdown now" }
local reboot = { "Reboot", "systemctl reboot" }
local suspend = { "Suspend", lock_command .. "systemctl suspend" }
local hibernate = { "Hibernate", lock_command .. "systemctl hibernate" }

local function menu()
  return { lock, shutdown, reboot, suspend }
end

local function naughty_destroy_callback(reason)
  if reason == naughty.notificationClosedReason.expired then
    local action = state.index and state.menu[state.index - 1][2]
    if action then
      spawn(string.format("sh -c \'%s\'", action), false)
      state.index = nil
    end
  end
end

local function exit()
  if not state.index then
    state.menu = menu()
    state.index = 1
  end

  local label, action
  local next = state.menu[state.index]
  state.index = state.index + 1

  if not next then
    label = 'Do nothing'
    state.index = nil
  else
    label, action = next[1], next[2]
  end

  state.cid = naughty.notify({
    title = "Awesome WM Exit",
    text = string.format("  <span color='yellow' weight='bold'>%-10s ?</span>", label),
    icon = icon_path,
    timeout = 3,
    screen = mouse.screen,
    replaces_id = state.cid,
    destroy = naughty_destroy_callback
  }).id
end

return {
  exit = exit,
  commands = {
    lock = lock,
    shutdown = shutdown,
    reboot = reboot,
    suspend = suspend,
    hibernate = hibernate
  }
}
