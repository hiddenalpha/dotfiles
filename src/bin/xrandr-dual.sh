#!/bin/sh

echo "TODO: Needs configuration."; exit 1;

xrandr --output HDMI-1 --auto --pos 0x0 --primary \
       --output eDP-1 --preferred --pos 1920x100

