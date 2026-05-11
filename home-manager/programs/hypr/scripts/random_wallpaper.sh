#!/usr/bin/env bash

WALLPAPER_DIR="/home/fanzi03/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)
FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
echo > "$WALLPAPER, $CURRENT_WALL"
#echo > "$(ls /home/fanzi03/wallpapers/)"

hyprctl hyprpaper reload "$FOCUSED_MONITOR", "$WALLPAPER"
