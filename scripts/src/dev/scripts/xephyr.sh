#!/bin/sh
Xephyr -ac -screen 1920x1080 :99 &
export DISPLAY=:99
awesome -c ~/.config/awesome/rc.lua > /tmp/awesomewm.log
