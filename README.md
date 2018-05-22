# About

This container is grabbing web page (picture + audio) using web browser and transcode it in rtmp video stream. 

### How to use

```bash
$ docker run -it --rm \
      -e GRAB_URL="https://lenta.ru" \
      -e RTMP_URL="rtmp://a.rtmp.youtube.com/live2/yke7-5efb-vkbq-d7rz" \
      -e LANGUAGE="en" \
      -e V_BITRATE="2500K" \
      -e A_BITRATE="256K" \
      kolyadin/live-video-broadcasting
```