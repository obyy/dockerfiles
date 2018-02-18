#! /bin/sh
if [ "$1" = "-h" ]; then
	echo "start the command with :"
	echo "
docker run -d \\
-v /etc/localtime:/etc/localtime:ro \\
-v /tmp/.X11-unix:/tmp/.X11-unix \\
-e UID=1000 -e DISPLAY=:0 \\
--userns=host \\
--device /dev/snd:/dev/snd \\
-v \$HOME/.spotify/config:/spotify/.config/spotify \\
-v \$HOME/.spotify/cache:/spotify/spotify \\
--name spotify obyy/spotify:latest
"
	exit 0
fi


useradd -m -d /spotify -u ${UID:-9001} user
chown user:user -R /spotify
gpasswd -a user audio


echo "STARTING Spotify with UID=${UID:-9001}"
gosu user spotify
