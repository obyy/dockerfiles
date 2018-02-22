FROM python:2-alpine3.7

RUN apk update && apk --no-cache add git su-exec \
  && git clone https://github.com/Tautulli/Tautulli.git /opt/ \
  && mkdir /config \
  && rm -r /var/cache/apk/*
copy . /
EXPOSE 8181
VOLUME /config

ENTRYPOINT ["/entrypoint.sh"]
