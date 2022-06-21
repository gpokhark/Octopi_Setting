#!/bin/bash/
# keep wifi alive
ping -c3 192.168.0.1
if [ $? != 0 ]; then
  echo "......"
  echo "No network connection, restarting wlan0"

  ifconfig wlan0 down
  sleep 30
  ifconfig wlan0 up

else
  echo "Wifi working normally."
fi