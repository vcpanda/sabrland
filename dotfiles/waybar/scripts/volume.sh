#!/bin/bash

wpctl_out=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
vol_raw=$(echo "$wpctl_out" | awk '{print $2}')
vol_int=$(echo "$vol_raw" | awk '{print int($1 * 100)}')

is_muted=false
if echo "$wpctl_out" | grep -q "MUTED"; then
    is_muted=true
fi

sink=$(wpctl status | awk '/Sinks:/,/Sources:/' | grep '\*' | cut -d'.' -f2- | sed 's/^[ \t]*//; s/ \[.*//')

if [ "$is_muted" = true ]; then
    icon="󰖁"
    vol_int=0
elif [ "$vol_int" -lt 50 ]; then
    icon="🔉"
else
    icon="🔊"
fi

bar_vol=$vol_int
if [ "$bar_vol" -gt 100 ]; then bar_vol=100; fi

filled=$((bar_vol / 10))
empty=$((10 - filled))

bar=""
pad=""
for ((i=0; i<filled; i++)); do bar="${bar}█"; done
for ((i=0; i<empty; i++)); do pad="${pad}░"; done
ascii_bar="[${bar}${pad}]"

if [ "$is_muted" = true ] || [ "$vol_int" -lt 10 ]; then
    fg="#bf616a"
elif [ "$vol_int" -lt 50 ]; then
    fg="#fab387"
else
    fg="#56b6c2"
fi

if [ "$is_muted" = true ]; then
    tooltip="Audio: Muted\nOutput: $sink"
else
    tooltip="Audio: ${vol_int}%\nOutput: $sink"
fi

echo "{\"text\":\"$icon $ascii_bar ${vol_int}%\", \"tooltip\":\"$tooltip\"}"
