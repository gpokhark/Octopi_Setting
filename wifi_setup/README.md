# Raspberry Pi Wi-Fi Keepalive

Automatically checks Wi-Fi connectivity and restarts the interface if offline. Uses systemd and nmcli (no ifconfig/cron).

### Files
- `check_wifi.sh`: Pings router and restarts Wi-Fi if no response.
- `wifi-keepalive.service`: One-shot systemd unit that runs the script.
- `wifi-keepalive.timer`: Runs the service every 5 minutes.
- `setup_wifi.sh`: Installs everything and enables the timer.
- `uninstall_wifi.sh`: Removes all installed components.

## Setup
```bash
chmod +x setup_wifi.sh
./setup_wifi.sh
```
This:
- Copies the script to `/usr/local/bin/`
- Installs and enables the timer
- Starts the service immediately

Check status:
```bash
sudo systemctl status wifi-keepalive.timer
sudo systemctl status wifi-keepalive.service
```
### Logs
Wi-Fi recovery actions are logged to:
```bash
tail -n 30 /var/log/wifi-keepalive.log
```
(Log is created after first run)

Manually test the script:
```bash
sudo systemctl restart wifi-keepalive.service
```

If you change the .service or .timer file:
```bash
sudo systemctl daemon-reload
sudo systemctl restart wifi-keepalive.timer
```
### Uninstall
```bash
chmod +x uninstall_wifi.sh
./uninstall_wifi.sh
```
### Enable/Disable Logging
Logging is controlled via the ExecStart line in `wifi-keepalive.service`:
```bash
ExecStart=/bin/bash -c '/usr/local/bin/check_wifi.sh >> /var/log/wifi-keepalive.log 2>&1'
```
Remove >> ... to disable logging, then reload and restart the timer.