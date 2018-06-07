# Spotify
lancer une instanc de spotify : 

```console
docker run -d  \
  -h XBMC-docker \
  --user $(id -u ${USER}) \
  --name spotify-docker \
  --restart=on-failure:3 \
  --memory="700m" --memory-swap="700m"\
  -v $HOME/.config/spotify:/spotify \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /run/user/$(id -u ${USER})/pulse:/run/pulse:ro --device /dev/dri \
  --userns=host \
  --net=host \
  -e DISPLAY=unix${DISPLAY} \
  obyy/spotify:latest

```
