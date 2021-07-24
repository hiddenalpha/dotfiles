#!/bin/sh

set -e

REMOTE=HDMI-1
LOCAL=eDP-1

# Configure remote
xrandr --output "$REMOTE" --auto --pos 0x0

# Grab effective remote resolution
mode=$(xrandr | grep "$REMOTE" -A99 | awk '/[0-9]\*/ {print $1}')

# Adjust local like remote
xrandr --output "$LOCAL" --same-as "$REMOTE" --mode "$mode"

