#!/bin/bash
# uninstall_wifi.sh — Removes Wi-Fi keepalive systemd timer and script

set -e

echo "[−] Uninstalling Wi-Fi keepalive..."

sudo systemctl disable --now wifi-keepalive.timer || true
sudo systemctl disable --now wifi-keepalive.service || true

sudo rm -f /etc/systemd/system/wifi-keepalive.{service,timer}
sudo rm -f /usr/local/bin/check_wifi.sh

sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "[✓] Wi-Fi keepalive removed successfully."

