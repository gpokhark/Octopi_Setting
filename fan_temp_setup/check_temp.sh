#!/bin/bash
# check_temp.sh — Reads CPU temp, toggles GPIO fan on/off

ontemp=48
temp=$(vcgencmd measure_temp | grep -oE '[0-9]+\.[0-9]+')
temp0=${temp%.*}

echo "[i] CPU temp: ${temp0}°C"

if [ "$temp0" -gt "$ontemp" ]; then
    echo "[!] Temp > ${ontemp}°C — turning fan ON"
    # raspi-gpio set 23 op dh
    pinctrl set 23 op
    pinctrl set 23 dh
else
    echo "[✓] Temp <= ${ontemp}°C — turning fan OFF"
    # raspi-gpio set 23 op dl
    pinctrl set 23 op
    pinctrl set 23 dl
fi

