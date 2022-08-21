#!/bin/sh
# keep wifi alive
ping -c3 192.168.0.1 #router ip address
if [ $? != 0 ]; then
  echo "......"
  echo "No network connection, restarting wlan0"

  sudo ifconfig wlan0 down
  sleep 30
  sudo ifconfig wlan0 up

else
  echo "Wifi working normally."
fi