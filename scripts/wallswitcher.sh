#!/bin/bash

# Ensure this path is 100% correct
dir="$HOME/Pictures/wallpaper"

# Logic: List the files, pipe them to Rofi, capture the result
# FIXED: Added $ to dir, changed rofi-demenu to rofi -dmenu
choice=$(ls "$dir" | rofi -dmenu -i -p "select:")

# Guard Clause: Exit if nothing was picked
if [ -z "$choice" ]; then
    exit 1
fi

# Process Check: Ensure the NEW awww-daemon is running
if ! pgrep -x "awww-daemon" > /dev/null; then
    awww-daemon &
    sleep 0.2
fi

pkill mpvpaper

# Apply the wallpaper using the NEW awww binary
awww img "$dir/$choice" --transition-type grow