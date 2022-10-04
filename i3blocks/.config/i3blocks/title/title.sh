#!/bin/bash
title=$(xdotool getwindowname "$(xdotool getwindowfocus -f)")
main_title="$(echo "$title" | awk -F '-' '{ print ""$NF"" }')"
#echo "$main_title"
sub_title="${title%%"$main_title"}"
if [[ "${#sub_title}" -gt 32 ]]; then
  sub_title="${sub_title::25}... -"
fi
echo "$sub_title""$main_title"
