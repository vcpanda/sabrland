#!/bin/bash

brightness=$(brightnessctl get)
max_brightness=$(brightnessctl max)
percent=$((brightness * 100 / max_brightness))

filled=$((percent / 10))
empty=$((10 - filled))
bar=""
pad=""
for ((i=0; i<filled; i++)); do bar="${bar}█"; done
for ((i=0; i<empty; i++)); do pad="${pad}░"; done
ascii_bar="[${bar}${pad}]"

if [ "$percent" -lt 20 ]; then
    icon="󰃞"
    fg="#bf616a"
elif [ "$percent" -lt 55 ]; then
    icon="󰃟"
    fg="#fab387"
else
    icon="󰃠"
    fg="#56b6c2"
fi

device=$(brightnessctl --machine-readable | awk -F, 'NR==1 {print $1}')
tooltip="Brightness: ${percent}%\nDevice: $device"

echo "{\"text\":\"<span foreground='$fg'>$icon $ascii_bar ${percent}%</span>\", \"tooltip\":\"$tooltip\"}"
