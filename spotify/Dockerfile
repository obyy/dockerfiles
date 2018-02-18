FROM debian:stretch-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
	dirmngr \
	gosu \
	gnupg \
        alsa-utils \
        libxtst6 \
        libxss1 \
        libssl1.1 \
        libnss3 \
	libgl1-mesa-dri \
	libgl1-mesa-glx

RUN 	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 && \
	echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list && \
	apt-get update && apt-get install -y --no-install-recommends \
 	spotify-client && \
	rm -rf /var/lib/apt/lists/*

COPY . /

VOLUME /spotify

ENTRYPOINT ["/entrypoint.sh"]
