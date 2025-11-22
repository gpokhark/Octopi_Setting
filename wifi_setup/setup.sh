#!/bin/bash
# setup_wifi.sh — Sets up Wi-Fi keepalive script and systemd service

set -e

SCRIPT_NAME=check_wifi.sh
SCRIPT_PATH=/usr/local/bin/check_wifi.sh
SERVICE_FILE=wifi-keepalive.service
TIMER_FILE=wifi-keepalive.timer

echo "[+] Setting up Wi-Fi keepalive..."

# 1. Verify script exists
if [[ ! -f $SCRIPT_NAME ]]; then
  echo "[✗] Missing $SCRIPT_NAME"
  exit 1
fi

# 2. Copy and make executable
sudo cp "$SCRIPT_NAME" "$SCRIPT_PATH"
sudo chmod +x "$SCRIPT_PATH"
echo "[✓] Installed $SCRIPT_NAME to $SCRIPT_PATH"

# 3. Check .service references correct path
if ! grep -q "$SCRIPT_PATH" "$SERVICE_FILE"; then
  echo "[✗] $SERVICE_FILE does not reference $SCRIPT_PATH"
  exit 1
fi

# 4. Install systemd unit files
sudo cp "$SERVICE_FILE" /etc/systemd/system/
sudo cp "$TIMER_FILE" /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now "$TIMER_FILE"

echo "[✓] Wi-Fi keepalive service and timer active."

