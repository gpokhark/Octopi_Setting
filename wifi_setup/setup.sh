#!/bin/bash
# setup.sh — Deploys keepalive script and systemd units

set -e

echo "[+] Installing Wi-Fi keepalive"

sudo cp check_wifi.sh /usr/local/bin/check_wifi.sh
sudo chmod +x /usr/local/bin/check_wifi.sh

sudo cp wifi-keepalive.service /etc/systemd/system/
sudo cp wifi-keepalive.timer /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl enable --now wifi-keepalive.timer

echo "[✓] Setup complete. Timer is active:"
systemctl list-timers | grep wifi-keepalive

