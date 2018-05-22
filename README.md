# About

This container is grabbing web page via google chrome and transcode it with ffmpeg in rtmp video stream

### How to use

```bash
$ docker run -it --rm \
      -e GRAB_URL="https://lenta.ru" \
      -e RTMP_URL="rtmp://a.rtmp.youtube.com/live2/qvu0-zc7h-2qc0-7au9" \
      -e LANGUAGE="en" \
      kolyadin/live-video-broadcasting
```