FROM alpine:3.7

RUN apk update && apk add --no-cache apache2 php7 \
	php7-apache2 \
	php7-session \
	php7-dom \
	php7-fileinfo \
	php7-pdo_sqlite \
	php7-ctype \
	php7-sqlite3 \
	php7-curl \
	php7-gmp \
	php7-intl \
	php7-mbstring \
	php7-xml \
	php7-zip \
	php7-simplexml \
	curl && \
# logge to STDOUT et STDERR
	sed -ri -e 's!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g' -e 's!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g' "/etc/apache2/httpd.conf" && \
	mkdir /run/apache2 /freshrss && \
	cd /freshrss && \
	curl -fsSL https://github.com/FreshRSS/FreshRSS/archive/master.tar.gz | tar xz --strip 1 && \
	\
	mv /freshrss/data /freshrss/data_tmp

COPY . /


EXPOSE 80
VOLUME /freshrss/data
ENTRYPOINT ["/entrypoint.sh"]
