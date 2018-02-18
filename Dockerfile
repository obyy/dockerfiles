FROM debian:stretch

RUN apt-get update && apt-get install --no-install-recommends \
	dirmngr \
	gnupg && \
	\
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410 && \
	echo "deb http://repository.spotify.com stable non-free" > /etc/apt/sources.list.d/spotify.list && \
	
