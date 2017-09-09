#!/bin/bash

if [ $# -lt 2 ] ;then
	echo "Usage: $(basename $0) <size> <mountPoint>";
	echo "Eg: $(basename $0) 1G /mnt/tmpfs";
	exit;
fi

echo mount -t tmpfs -o size=$1 none "$2"
sudo mount -t tmpfs -o size=$1 none "$2"

