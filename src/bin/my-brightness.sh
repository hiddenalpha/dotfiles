#!/bin/bash
#
# @author Andreas Fankhauser
#
# This script required root access to some files in "/sys/class/backlight/".
# You may want to make root owner of this file and whitelist the script in the
# sudoers file:
# +----------------------------------------------------------------------------
# | Cmnd_Alias CMD_BRIGHTNESS = /path/to/this/script/my-brightness.sh
# | yourUsername ALL=(ALL) NOPASSWD: CMD_BRIGHTNESS
# +----------------------------------------------------------------------------


cur=$( cat /sys/class/backlight/intel_backlight/brightness )
min=$( cat /sys/class/backlight/intel_backlight/bl_power )
max=$( cat /sys/class/backlight/intel_backlight/max_brightness )
range=$( echo $max-$min | bc )

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


if [ "$EUID" -ne 0 ] ;then
	# We're not root. Run ourself with root privileges.
	sudo $0 $@;
	exit;
fi


level=$1


if [[ "$level" =~ ^[+|-] ]] ;then
	# Calculate absolute for specified relative value.
	level=$( echo "0$level+$curPercent" | bc )
fi

# Fix max and min exceedations.
if [ $level -lt 2 ] ;then
	echo "[WARN ] Level '$level' set to 2.";
	level=2
elif [ $level -gt 100 ] ;then
	echo "[WARN ] Level '$level' cut to 100."
	level=100
fi

echo "[INFO ] New level is $level"

# Translate percent to target scale
nxt=$( echo $level*$range/100 | bc )

# Write evaluated brightness

# Variant using hardware (usually sudo required)
echo $nxt | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null

# Software variant (usually sudo NOT required).
#xrandr  \
#	--output DVI-I-1 --brightness $level  \
#	--output HDMI-0 --brightness $level  \
#	--output DVI-D-0 --brightness $level  \
#;

