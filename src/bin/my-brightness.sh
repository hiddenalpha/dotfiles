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


input=$1
cur=$( cat /sys/class/backlight/intel_backlight/brightness )
min=$( cat /sys/class/backlight/intel_backlight/bl_power )
max=$( cat /sys/class/backlight/intel_backlight/max_brightness )
range=$( echo $max-$min | bc )


if [ -z $1 ] ;then
	# No argument given. Print current brightness in percent.
	echo $( echo "($cur-$min)*100/$range" | bc )
	exit;
fi


if [ "$EUID" -ne 0 ] ;then
	# We're not root. Run ourself with root privileges.
	sudo $0 $@;
	exit;
fi


level=$1


if [ -z $level ] ;then
	echo usage:  $0 level
	echo
	echo @param level:
	echo "	a number between 0 and 100 indicating the brightness."
	echo
	exit
fi


if [ $input -lt 2 ] ;then
	echo "You shouldn't set level below 1";
	exit;
fi


nxt=$( echo $input*$range/100 | bc )

# Variant using hardware (usually sudo required)
echo $nxt | sudo tee /sys/class/backlight/intel_backlight/brightness > /dev/null

# Software variant (usually sudo NOT required).
#xrandr  \
#	--output DVI-I-1 --brightness $level  \
#	--output HDMI-0 --brightness $level  \
#	--output DVI-D-0 --brightness $level  \
#;

