#!/bin/bash
# setup_fan.sh — Sets up fan temperature control script and systemd service

set -e

SCRIPT_NAME=check_temp.sh
SCRIPT_PATH=/usr/local/bin/check_temp.sh
SERVICE_FILE=fan-control.service
TIMER_FILE=fan-control.timer

echo "[+] Setting up fan control..."

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

echo "[✓] Fan control service and timer active."

