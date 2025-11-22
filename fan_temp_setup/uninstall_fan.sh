#!/bin/bash
# uninstall_fan.sh — Removes temperature-based fan control systemd timer and script

set -e

echo "[−] Uninstalling fan control..."

sudo systemctl disable --now fan-control.timer || true
sudo systemctl disable --now fan-control.service || true

sudo rm -f /etc/systemd/system/fan-control.{service,timer}
sudo rm -f /usr/local/bin/check_temp.sh

sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "[✓] Fan control removed successfully."

