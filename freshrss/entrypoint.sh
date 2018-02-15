#! /bin/sh

if [ ! -d /freshrss/data/users ]; then
	cp -r /freshrss/data_tmp/* /freshrss/data/
fi

if ! chown -R :apache /freshrss/data; then
	echo "bad owner for /freshrss/data"
	echo "/freshrss/data must own to $(id -nu) (uid:$(id -u)) or $(id -nu apache) (uid:$(id -u apache))"
	exit 1
fi

if ! chmod -R g+w /freshrss/data; then
        echo "bad write permission access/freshrss/data"
        echo "/freshrss/data must have write permission access"
        exit 1
fi



echo "${CRON:-*/30 * * * *} /usr/bin/php7 -f /freshrss/app/actualize_script.php > /log" > /var/spool/cron/crontabs/apache && \
crond
httpd -D FOREGROUND
#exec $@
