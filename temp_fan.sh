#!/bin/sh
ontemp=48
temp=$(vcgencmd measure_temp | egrep -o '[0-9]*\.[0-9]*')
echo $temp
temp0=${temp%.*}
echo $temp0

if [ $temp0 -gt $ontemp ]
then
        echo greater than $ontemp fan on
        # fan is connected to gpio pin 23
        raspi-gpio set 23 op dh
else
        echo less than or equal to $ontemp fan off
        raspi-gpio set 23 op dl
fi