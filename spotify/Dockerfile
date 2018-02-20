FROM ubuntu

RUN apt-get update && apt-get install -y --no-install-recommends \
	dirmngr \
	gosu \
	gnupg \
        xdg-utils libxss1 pulseaudio fonts-noto


RUN 	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 && \
	echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list && \
	apt-get update && apt-get install -y --no-install-recommends \
 	spotify-client \
	&& echo enable-shm=no >> /etc/pulse/client.conf \
	&& rm -rf /var/lib/apt/lists/* && apt-get clean

ENV PULSE_SERVER /run/pulse/native

COPY . /

VOLUME /spotify

ENTRYPOINT ["/entrypoint.sh"]
