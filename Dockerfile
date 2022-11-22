ARG ALPINE_VERSION=latest

FROM alpine:$ALPINE_VERSION

WORKDIR /psql

COPY pkg/entrypoint.sh /psql/

ENTRYPOINT [ "/bin/sh", "entrypoint.sh", "world" ]