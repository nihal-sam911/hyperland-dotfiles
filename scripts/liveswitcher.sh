#!/bin/bash

# 1. Configuration
VIDEO_DIR="$HOME/Videos/live"
MONITOR=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name' || echo "WL-1")

# 2. Selection via Rofi
# Using find to ensure we only grab video containers
SELECTION=$(find "$VIDEO_DIR" -maxdepth 1 -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.mov" \) -printf "%f\n" | rofi -dmenu -i -p "Live Wallpaper:")

# 3. Execution Logic
if [ -n "$SELECTION" ]; then
    FULL_PATH="$VIDEO_DIR/$SELECTION"

    # 4. Kill existing mpvpaper instances to free the socket/buffer
    pkill mpvpaper
    pkill awww-daemon

    # 5. Launch the new video background
    # --mpv-options allows passing hardware acceleration and looping flags
    mpvpaper -o "loop --no-audio hwdec=auto" eDP-1 "$FULL_PATH" &
else
    echo "Selection cancelled."
fi