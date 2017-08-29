
synclient TouchpadOff=`synclient | awk '/^    TouchpadOff             = ([0-9]+)$/ { print $3==1 ? 0 : 1 }'`

