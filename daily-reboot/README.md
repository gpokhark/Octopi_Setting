# Raspberry Pi Daily Reboot (2 AM)

This systemd-based setup automatically reboots your Raspberry Pi every day at 2:00 AM. It optionally logs each reboot trigger to `/var/log/daily-reboot.log`.

### Files

- `daily-reboot.service`: Triggers a reboot with optional logging
- `daily-reboot.timer`: Schedules the service daily at 2 AM
- `setup_reboot.sh`: Installs and activates the reboot timer
- `uninstall_reboot.sh`: Removes all reboot-related files

## Setup
```bash
chmod +x setup_reboot.sh
./setup_reboot.sh
```
Check the timer:
```bash
systemctl list-timers | grep daily-reboot
```

### Log
Reboot triggers are logged to:
```bash
tail -n 30 /var/log/daily-reboot.log
```
(Only appears after the first scheduled reboot or manual run.)

- Manual Test
```bash
sudo systemctl start daily-reboot.service
```
- Uninstall
```bash
chmod +x uninstall_reboot.sh
./uninstall_reboot.sh
```