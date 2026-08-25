#!/bin/bash

if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q 'MUTED'; then
    echo '{"text": "<span foreground=\"#fab387\">[ 󰍭 ]</span>", "tooltip": "Microphone: Muted"}'
else
    echo '{"text": "<span foreground=\"#56b6c2\">[ 󰍬 ]</span>", "tooltip": "Microphone: Active"}'
fi
