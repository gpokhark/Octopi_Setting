#!/bin/bash
# setup.sh — Deploys fan control service and timer

set -e

echo "[+] Installing fan control service..."

sudo cp check_temp.sh /usr/local/bin/check_temp.sh
sudo chmod +x /usr/local/bin/check_temp.sh

sudo cp fan-control.service /etc/systemd/system/
sudo cp fan-control.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable --now fan-control.timer

echo "[✓] Fan control setup complete. Timer status:"
systemctl list-timers | grep fan-control

