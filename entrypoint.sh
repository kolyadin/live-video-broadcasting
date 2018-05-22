#!/usr/bin/env bash

if [[ -z "$GRAB_URL" ]]; then
    echo "Must provide GRAB_URL in environment" 1>&2
    exit 1
fi

if [[ -z "$RTMP_URL" ]]; then
    echo "Must provide RTMP_URL in environment" 1>&2
    exit 1
fi

if [[ -z "$LANGUAGE" ]]; then
    #in debian this good for google chrome locale
    export LANGUAGE=ru
fi

sudo /etc/init.d/dbus start > /dev/null 2>&1

pulseaudio -D

pacmd load-module module-virtual-sink sink_name=v1
pacmd set-default-sink v1
pacmd set-default-source v1.monitor

#--force-device-scale-factor=2
xvfb-run --server-num 99 --server-args="-ac -screen 0 1280x720x24" \
    google-chrome-stable --no-sandbox --disable-gpu \
    --hide-scrollbars --disable-notifications \
    --disable-infobars --no-first-run \
    --lang=ru \
    --start-fullscreen --window-size=1280,720 \
    $GRAB_URL > /dev/null 2>&1 &

#if not wait, audio/video not sync (why?)
echo "Waiting some time to confirm chrome is running"
sleep 10

ffmpeg -thread_queue_size 512 -draw_mouse 0 \
    -f x11grab -r 30 -s 1280x720 -i :99 \
    -f alsa -ac 2 -i default \
    -vcodec libx264 -acodec aac -ab 256k \
    -preset ultrafast -crf 10 -threads 0 \
    -f flv $RTMP_URL