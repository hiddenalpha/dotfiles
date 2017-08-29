
synclient TapButton1=`synclient | awk '/TapButton1 *= *([0-9]+)/ {print $3==1?0:1}'`

