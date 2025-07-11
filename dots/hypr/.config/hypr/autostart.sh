#!/usr/bin/env bash

waybar &
dunst &
hyprpaper &

wl-paste --watch cliphist store &
wl-clip-persist --clipboard regular &

systemctl --user start polkit-kde-agent &

swayidle -w timeout 180 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' &

sleep 2 && nm-applet &

sleep 3 && kdeconnect-indicator &

sleep 4 && megasync &

