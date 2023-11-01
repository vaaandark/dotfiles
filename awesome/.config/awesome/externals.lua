local modkey = "Mod4"

local externals = {}

-- The things to do when start up
externals.startup = {
  'setxkbmap -option ctrl:swapcaps',
  'fcitx5 -r',
  'battery-check',
  "sh -c 'xss-lock --transfer-sleep-lock -- $HOME/.local/bin/fancy-lock && sleep 1 && systemctl suspend --nofork'",
  'set_backlight',
  'clash-verge',
  'copyq'
}

externals.keybindings = {
  { { modkey, "Control" }, "b", "firefox", "open firefox" },
  { { modkey, "Control" }, "t", "telegram-desktop", "open telegram" },
  { { modkey, "Control" }, "q", "/opt/QQ/qq", "open qq" },
  { { modkey, "Control" }, "e", "pcmanfm", "open pcmanfm" },
  { { modkey, "Control" }, "c", "code", "open visual studio code" },
  { { modkey, "Control" }, "o", "libreoffice", "open libreoffice" },
  { { modkey, "Control" }, "f", "feishu", "open feishu" },
  { { modkey, "Control" }, "m", "emoji-selector", "open emoji-selector" },
--  { { modkey }, "c", "find-cursor --size 100 --distance 1 --wait 50 --line-width 1 --color 'orange red'", "show cursor place" },
  { { modkey }, "c", "warpd --normal", "keyboard driven for mouse" },
  { { modkey }, "g", "warpd --grid", "keyboard driven for mouse" },
--  { { modkey }, "x", "warpd --hint", "keyboard driven for mouse" },
  { {}, "Print", "flameshot gui", "sreen shot" },
  { { "Control" }, "Print", "window-shot", "window shot" },
  { {}, "XF86AudioRaiseVolume", "amixer set Master playback 5000+", "turn up the volume" },
  { {}, "XF86AudioLowerVolume", "amixer set Master playback 5000-", "turn down the volume" },
  { {}, "XF86AudioMute", "pactl set-sink-mute @DEFAULT_SINK@ toggle", "mute the volume" },
  { {}, "XF86AudioMicMute", "pactl set-source-mute @DEFAULT_SOURCE@ toggle", "unmut the volume" },
  { {}, "XF86MonBrightnessUp", "lightup", "backlight up" },
  { {}, "XF86MonBrightnessDown", "lightdown", "backlight down" },
  { { "Control" }, ";", "copyq menu" }
}

return externals
