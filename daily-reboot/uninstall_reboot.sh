#!/bin/bash
# uninstall_reboot.sh — Removes the daily reboot service and timer

set -e

echo "[−] Uninstalling daily reboot..."

sudo systemctl disable --now daily-reboot.timer || true
sudo rm -f /etc/systemd/system/daily-reboot.{timer,service}

sudo systemctl daemon-reexec
sudo systemctl daemon-reload

echo "[✓] Daily reboot disabled and removed."
