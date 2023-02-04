#!/bin/sh

if acpi_info=$(acpi -b); then
  bat_level_all=$(echo "$acpi_info" | grep -v "unavailable" | grep -E -o "[0-9][0-9]?[0-9]?%")
  bat_level=$(echo "$bat_level_all" | awk -F"%" 'BEGIN{tot=0;i=0} {i++; tot+=$1} END{printf("%d%%\n", tot/i)}')

  is_charging=$(echo "$acpi_info" | grep -v "unavailable" | awk '{ printf("%s\n", substr($3, 0, length($3)-1) ) }')

  if [ "$is_charging" = "Charging" ]; then
    charging='+'
  fi

  printf "BAT %s%s\n" "$bat_level" "$charging"

  printf "%s\n" "$bat_level"

  if ! [ "$is_charging" = "Charging" ] && [ "${bat_level%?}" -le 15 ]; then
    printf '\n#FA1E44\n'
  fi

fi
