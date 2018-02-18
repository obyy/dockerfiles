#! /bin/sh

if [ ! -d /freshrss/data/users ]; then
	cp -r /freshrss/data_tmp/* /freshrss/data/
fi

adduser -D -u ${UID:-9001} user
chmod 777 /dev/pts/0
chown user /run/apache2

if ! chown -R :user /freshrss/data; then
	echo "bad owner for /freshrss/data"
	echo "/freshrss/data must own to $(id -nu) (uid:$(id -u)) or $(id -nu apache) (uid:$(id -u user))"
	exit 1
fi

if ! chmod -R g+w /freshrss/data; then
        echo "bad write permission access/freshrss/data"
        echo "/freshrss/data must have write permission access"
        exit 1
fi



echo "${CRON:-*/30 * * * *} /usr/bin/php7 -f /freshrss/app/actualize_script.php " > /var/spool/cron/crontabs/user
chown user:user /var/spool/cron/crontabs/user 
chmod 600 /var/spool/cron/crontabs/user
crond
echo "STARTING Apache with UID=${UID:-9001}"

if [ "$1" = "sh" ];then 
	/bin/sh
else
	exec su-exec user httpd -D FOREGROUND
fi
#exec $@
#$@
