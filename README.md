# fixcam.sh
- Its a shell script to set the focus, exposure for the camera.
- It runs automctically when we start the raspberry pi, for that I added following lines at the end of the `.bashrc` file
    ```bash
    #run fixcam.sh at startup
    echo "Running fixcam.sh"
    sh /home/pi/fixcam.sh
   ```

# Wi-Fi connectivity issue
- `check_wifi.sh` - script to check if raspberry pi is still connected to the wifi or not. If not then it restarts the wlan0.
- List all cron jobs `sudo crontab -l`
- Add a cron job to check the wifi connectivity every 5 minutes - `crontab -e`
```bash
# cron job for checking the wifi connection every 5 minutes
*/5 * * * * /home/pi/check_wifi.sh > /dev/null 2>&1
```
- Additiona resources - 
    - https://www.cyberciti.biz/faq/linux-show-what-cron-jobs-are-setup/
    - https://www.cyberciti.biz/faq/how-do-i-add-jobs-to-cron-under-linux-or-unix-oses/