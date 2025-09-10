#!/bin/bash

CAM_URL="YOUR_CAM_URL_USERNAME_AND_PASSWORD"
SAVE_DIR="PATH_WHERE_TO_SAVE"
DAYS_TO_KEEP=1  #SET THE DAYS

mkdir -p "$SAVE_DIR"

while true; do
    # Check if RTSP stream is reachable
    if ffprobe -rtsp_transport tcp -timeout 5000000 -i "$CAM_URL" -show_streams -loglevel error > /dev/null 2>&1; then
        echo "$(date): Stream available, starting recording..."
        ffmpeg -rtsp_transport tcp -i "$CAM_URL" \
            -c copy \
            -avoid_negative_ts make_zero \
            -f segment -strftime 1 \
            -segment_time 3600 \
            -reset_timestamps 1 \
            -segment_atclocktime 1 \
            "$SAVE_DIR/record_%Y-%m-%d_%H-%M-%S.mkv"
    else
        echo "$(date): Stream not available, retrying in 60s..."
        sleep 60
    fi    
done
