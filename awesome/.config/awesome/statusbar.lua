local awful = require("awful")
local wibox = require("wibox")
local lain = require("lain")

local function separator()
  return wibox.widget.textbox("  ")
end

local function vol()
  local volume = lain.widget.alsa {
    timeout = 1,
    settings = function()
      local vol_icon = " "
      if volume_now.status == "on" then
        vol_icon = " "
      end
      widget:set_markup(string.format("%s %d%%", vol_icon, volume_now.level)) end }
  return volume
end

local function devided_or_not(n)
  n = tonumber(n)
  if n > 1000 then
    return n / 1024
  else
    return nil
  end
end

local function mem()
  local mem_ = lain.widget.mem {
    settings = function()
      local used = devided_or_not(mem_now.used)
      if used then
        used = string.format("%.1fG", used)
      else
        used = string.format("%.1fM", mem_now.used)
      end
      widget:set_markup("  " .. used)
    end
  }
  return mem_.widget
end

local function cpu()
  local cpu_ = lain.widget.cpu {
    settings = function()
      widget:set_markup(string.format("  %3d%%", cpu_now.usage))
    end
  }
  return cpu_.widget
end

local function bat()
  local bat_icons = { " ", " ", " ", " " }
  local bat_ = lain.widget.bat {
    battery = "BAT0",
    notify = "off",
    settings = function()
      if bat_now.status ~= "N/A" then
        local text = tostring(bat_now.perc) .. "%"
        local bat_icon = bat_icons[(bat_now.perc - 1) // 25 + 1]
        if bat_now.status == "Charging" then
          bat_icon = " "
        end
        widget:set_markup(bat_icon .. "   " .. text)
      end
    end
  }
  return bat_.widget
end

local function net()
  local net_ = lain.widget.net {
    wifi_state = "on",
    settings = function()
      local sent = devided_or_not(net_now.sent)
      if sent then
        sent = string.format("%.1fM", sent)
      else
        sent = string.format("%.1fK", net_now.sent)
      end
      local received = devided_or_not(net_now.received)
      if received then
        received = string.format("%.1fM", received)
      else
        received = string.format("%.1fK", net_now.received)
      end
      widget:set_markup("   " .. sent .. " /   " .. received)
    end
  }
  return net_.widget
end

local function task()
  return awful.widget.watch('sh -c "task | tail -n 1 | tr [:lower:] [:upper:]"', 60)
end

return {
  separator = separator,
  net = net,
  mem = mem,
  cpu = cpu,
  bat = bat,
  vol = vol,
  task = task,
}
