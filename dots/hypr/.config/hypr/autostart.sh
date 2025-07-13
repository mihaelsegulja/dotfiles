#!/usr/bin/env bash

waybar &
dunst &
hyprpaper &
waypaper --restore &

wl-paste --watch cliphist store &
wl-clip-persist --clipboard regular &

/usr/lib/polkit-kde-authentication-agent-1 &

swayidle -w timeout 180 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' &

sleep 2 && nm-applet &

sleep 3 && kdeconnect-indicator &

sleep 4 && megasync &

