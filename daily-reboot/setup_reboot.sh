#!/bin/bash
# setup_reboot.sh — Installs systemd timer for daily reboot at 2 AM

set -e

echo "[+] Installing daily reboot timer..."

sudo cp daily-reboot.service /etc/systemd/system/
sudo cp daily-reboot.timer /etc/systemd/system/

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now daily-reboot.timer

echo "[✓] Daily reboot timer is active:"
systemctl list-timers | grep daily-reboot
