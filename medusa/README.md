#medusa
image docker de [medusa](https://github.com/pymedusa/Medusa).
```shell
docker run -d --name medusa \
  --restart=unless-stopped \
  --net=frontend \
  -v ~/data/medusa:/config \
  -v /media/tv:/tv \
  -v /media/filter:/filter \
  -e UID=1000 --userns host \
  -p 8081:8081 \
  -e TZ=Europe/Paris \
  obyy/medusa:latest

```


