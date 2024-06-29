#!/bin/sh
# keep wifi alive
router_ip=$(ip route | grep default | awk '{print $3}')
ping -c3 ${router_ip} #router ip address
if [ $? != 0 ]; then
  echo "......"
  echo "No network connection, restarting wlan0"

  sudo ifconfig wlan0 down
  sleep 30
  sudo ifconfig wlan0 up

else
  echo "Wifi working normally."
fi