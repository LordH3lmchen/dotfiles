#!/usr/bin/env zsh
set -x

# 
WALLPAPER_W_DIR="$HOME/Pictures/Wallpapers/wide" # 16:9
WALLPAPER_UW_DIR="$HOME/Pictures/Wallpapers/ultra-wide" # 21:9 
WALLPAPER_DUAL_DIR="$HOME/Pictures/Wallpapers/dual" # 32:9
WALLPAPER_VERTICAL_DIR="$HOME/Pictures/Wallpapers/vertical" # vertical


CURRENT_WALL=$(hyprctl hyprpaper listloaded)
# Get the name of the focused monitor with hyprctl
FOCUSED_MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
if [[ -n $1 ]]; then
    FOCUSED_MONITOR=$1
fi
MONITOR_TRANSFORM=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$FOCUSED_MONITOR\" ) | .transform")
# MONITOR_TRANSFORM=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .transform')

if [[ $MONITOR_TRANSFORM -eq 0 || $MONITOR_TRANSFORM -eq 2 ]]; then #Dislpay normal or up side down 
    echo "Monitor Horizontal"
    typeset -F FM_WIDTH
    typeset -F FM_HEIGHT
    FM_WIDTH=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .width')
    FM_HEIGHT=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .height')
    if [[ $FM_WIDTH/$FM_HEIGHT -lt 1.3 ]]; then
        echo "Monitor 5:4"
        WALLPAPER_DIR=$WALLPAPER_W_DIR
    elif [[ $FM_WIDTH/$FM_HEIGHT -lt 1.65 ]]; then
        echo "Monitor 16:10"
        WALLPAPER_DIR=$WALLPAPER_W_DIR
    elif [[ $FM_WIDTH/$FM_HEIGHT -lt 1.8 ]]; then
        echo "Monitor 16:9"
        WALLPAPER_DIR=$WALLPAPER_W_DIR
    elif [[ $FM_WIDTH/$FM_HEIGHT -lt 2.39 ]]; then
        echo "Monitor 21:9"
        WALLPAPER_DIR=$WALLPAPER_UW_DIR
    elif [[ $FM_WIDTH/$FM_HEIGHT -lt 2.45 ]]; then
        echo "Monitor 24:10"
        WALLPAPER_DIR=$WALLPAPER_UW_DIR
    else #  [[ $FM_WIDTH/$FM_HEIGHT -gt 3.5 ]]; then
        echo "Monitor 32:9"
        WALLPAPER_DIR=$WALLPAPER_DUAL_DIR
    fi
elif [[  $MONITOR_TRANSFORM -eq 1 || $MONITOR_TRANSFORM -eq 3 ]]; then
    echo "Monitor Vertical"
    WALLPAPER_DIR=$WALLPAPER_VERTICAL_DIR
fi
# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

# Apply the selected wallpaper
wal --cols16 lighten -i $WALLPAPER
hyprctl hyprpaper reload "$FOCUSED_MONITOR","$WALLPAPER"
pkill waybar
waybar &


