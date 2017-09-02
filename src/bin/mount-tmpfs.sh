#!/bin/bash

if [ $# -lt 1 ] ;then
	echo "Usage: $(basename $0) <size>";
	echo "Eg: $(basename $0) 1G";
	exit;
fi

echo mount -t tmpfs -o size=$1 none /mnt/tmpfs
sudo mount -t tmpfs -o size=$1 none /mnt/tmpfs

