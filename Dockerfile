ARG ALPINE_TAG=latest

FROM alpine:$ALPINE_TAG

RUN apk update && apk --no-cache add postgresql-client

WORKDIR /psql

COPY pkg/entrypoint.sh /psql/

ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]