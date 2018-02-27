# Spotify
lancer une instanc de spotify : 

```console
docker run -h spotify-obyy --name spotify-obyy \
  -v /etc/localtime:/etc/localtime:ro \
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
  -v /run/user/$UUID/pulse:/run/pulse:ro  \
  --device /dev/dri \
  --userns=host \
  --net=host \
  -e UID=$UUID -e DISPLAY=:0  \
  -v $HOME/spotify \
  obyy/spotify
```
