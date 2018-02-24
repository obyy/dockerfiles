un petit repo pour lister l'ensemble de mes dockerfiles. Je m'efforce de faire les plus petites images docker possible.

# Freshrss
[![](https://images.microbadger.com/badges/image/obyy/freshrss-alpine.svg)](https://microbadger.com/images/obyy/freshrss-alpine "Get your own image badge on microbadger.com")

Container pour lancé une instance de [freshrss](https://freshrss.org) qui tourne sous apache et mod_php 7, et sur une base de donnée SQLite.
La base de donné sqlite est plus simple pour la sauvegarde du profile utilisateur, et souvent plus rapide qu'un serveur Postgresql
De base le conteneur se lance sans processus root.
2 variables d'environnements peuvent être selectionnée pour afiner le reglage.
```shell
docker run --name freshrss \
  -v ~/data/freshrss:/freshrss/data \
  -p 9898:8080 \
  obyy/freshrss-alpine
```
La syncrhonisation par defaut se lance avec un script et une tache sleep toutes les 30minutes, la valeur de la tache sleep peut être modifier avec la variable d'environnement UPDATE `-e UPDATE=20m` (toutes les 20minutes)
```shell
docker run --name freshrss \
  -e UPDATE="1h" \
  -v ~/data/freshrss:/freshrss/data \
  -p 9898:8080 \
  obyy/freshrss-alpine
```

Syncrhonisation avec une tache cron toutes les heures à la 5ème minute, cron doit être lancé en root.
```shell
docker run --name freshrss \
  -e CRON="5 * * * *" \
  -v ~/data/freshrss:/freshrss/data \
  -p 9898:8080 \
  obyy/freshrss-alpine
```

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
