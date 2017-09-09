#!/bin/bash

if [ $# -lt 1 ] ;then
	echo "Usage: $(basename $0) <mountPoint>";
	echo "E.g:   $(basename $0) /mnt/tmpfs"
	exit;
fi

echo sudo umount "$1"
sudo umount "$1"

