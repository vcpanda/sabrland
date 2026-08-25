#!/bin/bash

WORKSPACE=$1

if [ -z "$WORKSPACE" ]; then
    echo '{"text": "[ ? ]", "class": "idle"}'
    exit 0
fi

CLIENTS=$(hyprctl clients -j 2>/dev/null | jq -r ".[] | select(.workspace.id == $WORKSPACE) | .class" 2>/dev/null | tr '[:upper:]' '[:lower:]')


if [ -z "$CLIENTS" ]; then
    echo "{\"text\": \"[ $WORKSPACE ]\", \"class\": \"idle\"}"
    exit 0
fi

if echo "$CLIENTS" | grep -E -q "firefox|chromium|brave|yandex|opera"; then
    echo "{\"text\": \"[ 🌐 $WORKSPACE ]\", \"class\": \"browser\"}"

elif echo "$CLIENTS" | grep -E -q "kitty|alacritty|wezterm|konsole|qterminal|gnome-terminal"; then
    echo "{\"text\": \"[ 💻 $WORKSPACE ]\", \"class\": \"code\"}"

elif echo "$CLIENTS" | grep -E -q "code|vscodium|nvim|vim|sublime|geany"; then
    echo "{\"text\": \"[ 📝 $WORKSPACE ]\", \"class\": \"code\"}"

elif echo "$CLIENTS" | grep -E -q "telegram|discord|slack"; then
    echo "{\"text\": \"[ 💬 $WORKSPACE ]\", \"class\": \"chat\"}"

elif echo "$CLIENTS" | grep -E -q "steam|lutris|heroic"; then
    echo "{\"text\": \"[ 🎮 $WORKSPACE ]\", \"class\": \"steam\"}"

elif echo "$CLIENTS" | grep -E -q "thunar|dolphin|nemo|ranger"; then
    echo "{\"text\": \"[ 📁 $WORKSPACE ]\", \"class\": \"idle\"}"

else
    echo "{\"text\": \"[ 🗔 $WORKSPACE ]\", \"class\": \"idle\"}"
fi
