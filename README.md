# fixcam.sh
- Its a shell script to set the focus, exposure for the camera.
- It runs automctically when we start the raspberry pi, for that I added following lines at the end of the `.bashrc` file
    ```bash
    #run fixcam.sh at startup
    echo "Running fixcam.sh"
    sh /home/pi/fixcam.sh
   ```
- `undo_fixcam.sh` is a file to undo the effects of `fixcam.sh`.

# Wi-Fi connectivity issue
- `check_wifi.sh` - script to check if raspberry pi is still connected to the wifi or not. If not then it restarts the wlan0.
- Add a cron job to check the wifi connectivity every 5 minutes - `sudo crontab -e`
    ```bash
    # cron job for checking the wifi connection every 5 minutes
    */5 * * * * /home/pi/check_wifi.sh > /dev/null 2>&1
    ```
- Additiona resources - 
    - https://www.cyberciti.biz/faq/linux-show-what-cron-jobs-are-setup/
    - https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/

# Automatic temperature controlled fan
- `my_pi_temp.sh` - shell script to check the raspberry pi GPU and CPU temperature. Source - [link](https://www.cyberciti.biz/faq/linux-find-out-raspberry-pi-gpu-and-arm-cpu-temperature-command/)
- `temp_fan.sh` - shell script that automatically checks the raspberry pi temperature and turns on the fan if the temperature is above **48 degree C**. Source - [link](https://embeddedcomputing.com/technology/software-and-os/ides-application-programming/raspberry-pi-cooling-fan-control-with-bash-scripting)
- Add a cron job to check the temperature every 2 minutes - `sudo crontab -e`
    ```bash
    # cron job for checking the wifi connection every 5 minutes
    */2 * * * * /home/pi/temp_fan.sh > /dev/null 2>&1
   ```
- To use the `temp_fan.sh` script just as it is make sure that the fan is connected to **GPIO pin 23** or else update the gpio pin number in the script accordingly.

# Difference between #!/bin/bash and #!/bin/sh
- Read this link - https://askubuntu.com/questions/141928/what-is-the-difference-between-bin-sh-and-bin-bash.
- Make sure that your raspberry pi scripts are `#!/bin/sh`

# cron job 
- List all cron jobs - `sudo crontab -l`
- Add or Modify cron job - `sudo crontab -e`
- Cron job logs - `grep CRON /var/log/syslog`