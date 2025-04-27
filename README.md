# Octopi Setting
- This repository will provide help and guidance to setup Octoprint on a raspberry pi.
- Clone this repository for help with regards to setting up camera and to deal with the wifi connectivity issue.

# fixcam.sh
- Its a shell script to set the focus, exposure for the camera.
- It runs automctically when we start a terminal session for this raspberry pi, for that I added following lines at the end of the `.bashrc` file
    ```bash
    #run fixcam.sh at startup
    echo "Running fixcam.sh"
    sh /home/pi/Octopi_Setting/fixcam.sh
   ```
- `undo_fixcam.sh` is a file to undo the effects of `fixcam.sh`.
- Add following lines to `/etc/rc.local` file to automatically run the script at startup. This does not need us to start any terminal session.
    ```bash
    sudo nano /etc/rc.local
    #run fixcam.sh at startup
    echo "Running fixcam.sh"
    sh /home/pi/Octopi_Setting/fixcam.sh

    exit 0
    ```
- Check what controls your camera actually supports
    ```bash
    v4l2-ctl -d /dev/video0 --list-ctrls
    ```
- Run following steps to enable fixcam.service at boot -
    - Copy paste the `fixcam.service` file - `sudo cp fixcam.service /etc/systemd/system/fixcam.service`.
    - Now tell systemd to recognize the new service - `sudo systemctl daemon-reload`.
    - Enable the service to run at boot - `sudo systemctl enable fixcam.service`.
    - Start the service manually - `sudo systemctl start fixcam.service`.
    - Check the status - `sudo systemctl status fixcam.service`.


# Raspberry pi static ip address
- To setup static ip address for your raspberry pi - https://www.makeuseof.com/raspberry-pi-set-static-ip/
- Add following lines to `sudo nano /etc/wpa_supplicant/wpa_supplicant.conf`
    ```text
    country=US
    ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
    ap_scan=1

    update_config=1
    network={
        ssid="SSID"
        psk="password"
        priority=1
    }

    network={
        ssid="SSID2"
        psk="password2"
        priority=2 #higher number indicates higher priority
    }
    ```
- Add following lines to the end of the file - `sudo nano /etc/dhcpcd.conf`
    ```text
    interface wlan0
    static ip_address=192.168.0.xx/24
    static routers=192.168.0.1
    static domain_name_servers=192.168.0.1 xx.xx.xx.xx
    ```

# Wi-Fi connectivity issue
- Ensure that you have setup static ip address for your raspberry pi.
- Ensure that the command `sudo ifconfig wlan0 up` and `sudo ifconfig wlan0 down` works without the user password requirement.
    - To run the aforementioned commands without password, do following steps
         ```bash
         cd /etc/sudoers.d
         sudo nano 010_pi-nopasswd
         ```
         Add following line to the file
         ```nano
         pi ALL=(ALL) NOPASSWD: /sbin/ifconfig wlan0 up, /sbin/ifconfig wlan0 down
         ```
         Here `pi` indicates the username of the raspberry update it as per your name.
    - Try running the command `sudo ifconfig wlan0 up` and `sudo ifconfig wlan0 down`, it shouldn't ask for password.
    - Beware before running the previous command ensure that you have not recently typed the password for any other `sudo` command or else try this in a new terminal.
    - To know more about this search the command - `sudo visudo`
- `check_wifi.sh` - script to check if raspberry pi is still connected to the wifi or not. If not then it restarts the wlan0.
- Add a cron job to check the wifi connectivity every 5 minutes - `sudo crontab -e`
    ```bash
    # cron job for checking the wifi connection every 5 minutes
    */5 * * * * /home/pi/Octopi_Setting/check_wifi.sh > /dev/null 2>&1
    ```
- Additiona resources - 
    - https://www.cyberciti.biz/faq/linux-show-what-cron-jobs-are-setup/
    - https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/
    - https://forums.fedoraforum.org/showthread.php?180471-Editing-sudoers-to-allow-ifconfig-only-on-certain-interfaces
    - https://unix.stackexchange.com/questions/163347/add-test-user-to-the-sudoers-file-to-run-ifconfig
    
# Automatic temperature controlled fan
- `my_pi_temp.sh` - shell script to check the raspberry pi GPU and CPU temperature. Source - [link](https://www.cyberciti.biz/faq/linux-find-out-raspberry-pi-gpu-and-arm-cpu-temperature-command/)
- `temp_fan.sh` - shell script that automatically checks the raspberry pi temperature and turns on the fan if the temperature is above **48 degree C**. Source - [link](https://embeddedcomputing.com/technology/software-and-os/ides-application-programming/raspberry-pi-cooling-fan-control-with-bash-scripting)
- Add a cron job to check the temperature every 2 minutes - `sudo crontab -e`
    ```bash
    # cron job for checking the wifi connection every 5 minutes
    */2 * * * * /home/pi/Octopi_Setting/temp_fan.sh > /dev/null 2>&1
   ```
- To use the `temp_fan.sh` script just as it is make sure that the fan is connected to **GPIO pin 23** or else update the gpio pin number in the script accordingly.

# Difference between #!/bin/bash and #!/bin/sh
- Read this link - https://askubuntu.com/questions/141928/what-is-the-difference-between-bin-sh-and-bin-bash.
- Make sure that your raspberry pi scripts are `#!/bin/sh`

# cron job 
- List all cron jobs - `sudo crontab -l`
- Add or Modify cron job - `sudo crontab -e`
- Cron job logs - `grep CRON /var/log/syslog`