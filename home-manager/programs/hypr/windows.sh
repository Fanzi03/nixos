#!/bin/bash

handle() {
  case $1 in
    workspace>>2)
      hyprctl hyprpaper wallpaper ",~/.config/hyprwall/windows.png"
      ;;
    workspace>>*)
      hyprctl hyprpaper wallpaper ",~/.config/hypr/wall/workspace2.jpg"
      ;;
  esac
}

socat -U - UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
