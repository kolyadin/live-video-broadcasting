FROM debian:9-slim

MAINTAINER Aleksey Kolyadin <donflash@gmail.com>

RUN apt-get update && apt-get install -y htop nano wget pulseaudio socat alsa-utils ffmpeg xvfb sudo

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb

COPY default.pa /etc/pulse/
COPY entrypoint.sh /var/

RUN chmod +x /var/entrypoint.sh

RUN useradd -ms /bin/bash webmaster \
    && touch /etc/sudoers.d/webmaster \
    && echo 'webmaster  ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/webmaster

USER webmaster
WORKDIR /var

ENTRYPOINT /var/entrypoint.sh