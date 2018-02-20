#! /bin/sh

if [ ! -d /freshrss/data/users ]; then
	cp -r /freshrss/data_tmp/* /freshrss/data/
fi

UID=${UID:-9001}
adduser -D -u ${UID} obyy

# eviter apache error acces
echo ServerName $(hostname) >> /etc/apache2/httpd.conf
chmod 333 /proc/self/fd/2 /proc/self/fd/1
chown obyy /run/apache2

#check data folder permission host
if ! chown -R :obyy /freshrss/data; then
	echo "bad owner for /freshrss/data"
	echo "/freshrss/data must own to $(id -nu) (uid:$(id -u)) or $(id -nu $UID) (uid:$(id -u $UID))"
	exit 1
fi
if ! chmod -R g+w /freshrss/data; then
        echo "bad write permission access /freshrss/data"
        echo "/freshrss/data must have write permission access"
        exit 1
fi

# create CRON for every 30min or a script. CRON need root :(
if [ "${CRON}" = "TRUE" ]; then
	echo "${CRON:-*/30 * * * *} /usr/bin/php7 -f /freshrss/app/actualize_script.php " > /var/spool/cron/crontabs/obyy
	chmod 600 /var/spool/cron/crontabs/obyy
	crond && echo "Starting crond with :"
	crontab -l -u obyy
else
	cat << EOF > /cron-script.sh
#!/bin/sh
while true; do
	/usr/bin/php7 -f /freshrss/app/actualize_script.php
	sleep 30m
done
EOF
	chmod +x /cron-script.sh
	su-exec obyy /cron-script.sh &
fi


echo "STARTING Apache with UID=${UID}"
if [ "$1" = "sh" ];then
	/bin/sh
else
	exec su-exec obyy httpd -D FOREGROUND
fi
