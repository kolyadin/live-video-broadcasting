FROM debian:9-slim

MAINTAINER Aleksey Kolyadin <aleksey@kolyadin.ru>

RUN apt-get update && apt-get install -y htop nano wget pulseaudio socat alsa-utils ffmpeg xvfb sudo nginx

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt install -y ./google-chrome-stable_current_amd64.deb

COPY default.pa /etc/pulse/
COPY entrypoint.sh /var/
COPY nginx.conf /etc/nginx/sites-enabled/default

RUN sudo chmod +x /var/entrypoint.sh

RUN useradd -ms /bin/bash webmaster \
    && touch /etc/sudoers.d/webmaster \
    && echo 'webmaster  ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/webmaster

RUN chown webmaster:webmaster /var

EXPOSE 80
USER webmaster
WORKDIR /var

ENTRYPOINT /var/entrypoint.sh