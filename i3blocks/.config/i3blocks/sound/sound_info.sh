#!/bin/sh
SOUND_LEVEL=$(amixer -M get Master | awk -F"[][]" '/%/ { print $2 }' | awk -F"%" 'BEGIN{tot=0; i=0} {i++; tot+=$1} END{printf("%s\n", tot/i) }')
MUTED=$(amixer get Master | awk ' /%/{print ($NF=="[off]" ? 1 : 0); exit;}')

if [ "$MUTED" = "1" ]; then
    echo "VOL MUTED"
else
    printf "VOL  %-4s\n" "$SOUND_LEVEL%"
fi

