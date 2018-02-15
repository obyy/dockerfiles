un petit repo pour lister l'ensemble de mes dockerfiles. Je m'efforce de faire les plus petites images docker possible.
# Freshrss
variable d'environnement "CRON"
```
docker run --name freshrss -it --rm -v ~/data/freshrss:/freshrss/data -p 9898:80 freshrss:1.8
```
ou un synchronisation toutes les heures a a 1 minutes
```
docker run --name freshrss -it --rm -e CRON="1 * * * *" -v ~/data/freshrss:/freshrss/data -p 9898:80 freshrss:1.8

```
