# Jackett

image docker de [Jackett](https://github.com/Jackett/Jackett).


```shell
docker run -d --name jackett \
  -p 9117:9117 \
  -v ~/data/jackett:/config \
  obyy/jackett:latest
```
