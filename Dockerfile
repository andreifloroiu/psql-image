ARG ALPINE_VERSION=latest

FROM alpine:$ALPINE_VERSION

RUN apk update && apk add postgresql-client

WORKDIR /psql

COPY pkg/entrypoint.sh /psql/

ENTRYPOINT [ "/bin/sh", "entrypoint.sh", "world" ]