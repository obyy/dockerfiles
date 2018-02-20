un petit repo pour lister l'ensemble de mes dockerfiles. Je m'efforce de faire les plus petites images docker possible.
# Freshrss
Container pour lancé une instance de freshrss qui tourne sous apache et mod_php 7, et sur une base de donnée SQLite.
La base de donné sqlite est plus simple pour la sauvegarde du profile utilisateur, et souvent plus rapide qu'un serveur Postgresql
De base le conteneur se lance sans processus root.
2 variables d'environnements peuvent être selectionnée pour afiner le reglage.
```
docker run --name freshrss -v ~/data/freshrss:/freshrss/data -p 9898:8080 obyy/freshrss-alpine
```
Syncrhonisation par defaut se lance avec un script et une tache sleep toutes les 30minutes, la valeur de la tache sleep peut être modifier avec la variable d'environnement UPDATE

```
docker run --name freshrss -e UPDATE="1h" -v ~/data/freshrss:/freshrss/data -p 9898:8080 obyy/freshrss-alpine
```

Syncrhonisation avec une tache cron toutes les heures à la 5ème minute, cron doit être lancé en root :(
```
docker run --name freshrss -e CRON="5 * * * *" -v ~/data/freshrss:/freshrss/data -p 9898:8080 obyy/freshrss-alpine
```
