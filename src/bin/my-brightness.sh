#!/bin/bash

#
# Software (no root) alternative to "my-backlight.sh"
#

level=$1
cur=$( xrandr --verbose | awk 'match($0,/Brightness: ([0-9\\.]+)/,m) {print m[1]}' )
cur=$( echo "$cur*100" | bc )
min=0
max=100
range=$( echo "$max-$min" | bc )

curPercent=$( echo "($cur-$min)*100/$range" | bc )

if [ $# -eq 0 ] ;then
	# No argument given. Print current brightness in percent.
	echo "$curPercent"
	exit;
elif [ "$1" == "--help" ] ;then
	echo "examples:"
	echo "	- $0 50   # Set brightness to 50%"
	echo "	- $0 +10  # Increase brightness by 10%"
	echo "	- $0 -10  # Decrease brightness by 10%"
	exit;
fi

if [[ "$level" =~ ^[+|-] ]] ;then
	# Calculate absolute for specified relative value.
	level=$( echo "0$level+$curPercent" | bc )
fi

# Fix max and min exceedations.
if [ $level -lt 10 ] ;then
	level=10
elif [ $level -gt 100 ] ;then
	level=100
fi

# Translate percent to target scale
nxt=$( echo $level*$range/100 | bc )
nxt=$( echo "scale=2;$level/100" | bc )

# Write evaluated brightness

echo xrandr --output LVDS-1 --brightness "$nxt"
xrandr --output LVDS-1 --brightness "$nxt"

