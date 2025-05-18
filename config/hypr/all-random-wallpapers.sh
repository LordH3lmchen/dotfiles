#!/usr/bin/env zsh

set -x

DISPLAYS=($(hyprctl monitors -j | jq -r '.[] | .name'))
print $DISPLAYS 

for d in $DISPLAYS; do
    ~/.config/hypr/random-wallpaper.sh $d
done


