# Bash script for CCTV footage recorder.
-  I have a Linux server setup at home and a Tp-Link Tapo camera and it has a SD-card slot for storage, I thought if someone tries to tamper with the camera there might be a chance that the SD card can also get tampered.
-  So why not store it somewhere safe.
-  The code is inside the code.sh file.
-  This script uses ffmpeg for recording and saving it.
-  There are various fields that needs to updated before running it.
-  This script should be setup as a systemd program , so that it can run with any issues.
-  Steps for systemd setup:
    * ` cd /etc/systemd/system`
    * create a file named `cctv.service`
    * `nano cctv.service`
    * Paste this:
        ```
        [Unit]
        Description=CCTV Auto Recorder
        After=network.target
        
        [Service]
        ExecStart=PATH_TO_BASH_SCRIPT
        Restart=always
        StandardOutput=append:PATH_TO_LOG_FILE
        StandardError=append:PATH_TO_ERROR_FILE
        
        [Install]
        WantedBy=multi-user.target
        ```
   * Then run these commands:
     ```
     sudo systemctl daemon-reload
     sudo systemctl enable cctv.service
     ```
   * You can check status by ` sudo systemctl status cctv.service`
-  Some fields need to be set like `CAM_URL`, `SAVE_DIR`,`DAYS_TO_KEEP`.
-  For Cam URL you can visit the respective camera website or documentation if TP-LINK camera [Link](https://www.tp-link.com/us/support/faq/2680/)
-  Days to keep for how many day's data you want to store.(Take this seriously and also keep in mind your available disk space and set accordingly).
