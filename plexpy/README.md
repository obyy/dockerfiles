# Plexpy
image docker de plexpy.
```shell
docker run --name plexpy \
  -v ~/data/plexpy:/config \
  obyy/plexpy
```

Or with specific user id.
```shell
docker run --name plexpy \
  -e UID=1000
  -v ~/data/plexpy:/config \
  obyy/plexpy
```


