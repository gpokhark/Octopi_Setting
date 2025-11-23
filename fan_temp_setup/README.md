# Raspberry Pi Fan Control
### Files
- `check_temp.sh`: Reads CPU temp and controls GPIO pin 23 (fan).
- `fan-control.service`: One-shot systemd unit to run the script.
- `fan-control.timer`: Runs the service every minute.
- `setup.sh`: Installs everything to /usr/local/bin and enables the timer.
- `uninstall_fan.sh`: Cleanly removes all files and disables the timer.

### Setup
```bash
chmod +x setup.sh
./setup.sh
```
This:
- Copies the script.
- Enables the timer.
- Starts the service immediately.
To confirm it's working:
```bash
sudo systemctl status fan-control.timer
sudo systemctl status fan-control.service
```
### Logs
Fan activity is logged at:
```bash
tail -n 30 /var/log/fan-control.log
```
(Only appears after the first run)
To manually run the script:
```bash
sudo systemctl restart fan-control.service
```
To reload systemd configs (after changes):
```bash
sudo systemctl daemon-reload
```
### Uninstall
```bash
chmod +x uninstall_fan.sh
./uninstall_fan.sh
```
### Enable/Disable Logging
Edit `fan-control.service` to toggle logging:
```bash
ExecStart=/bin/bash -c '/usr/local/bin/check_temp.sh >> /var/log/fan-control.log 2>&1'
```
Remove >> ... to disable logging. Then:
```bash
sudo systemctl daemon-reload
sudo systemctl restart fan-control.timer
```
