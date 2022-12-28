#!/bin/bash
title=$(xdotool getwindowname "$(xdotool getwindowfocus -f)")
if [[ "$title" = "i3" ]]; then
  exit 0
fi
main_title="$(echo "$title" | awk -F '[—-]' '{ print ""$NF"" }')"
sub_title="${title%%"$main_title"}"
if [[ "${#sub_title}" -gt 25 ]]; then
  sub_title="${sub_title::20}... -"
fi
main_len="${#main_title}"
if [[ main_len -gt 25 ]]; then
  main_title="... ${main_title:main_len-20:20}"
fi
echo "$sub_title""$main_title" | tr '[:lower:]' '[:upper:]'
