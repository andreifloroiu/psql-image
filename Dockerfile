ARG ALPINE_TAG=latest

FROM alpine:$ALPINE_TAG

ENV PSQL_CONNECTION_STRING=
ENV PSQL_SCRIPT_FILE=script.sh
ENV PSQL_SCRIPT=

RUN apk update && apk --no-cache add postgresql-client

WORKDIR /psql

COPY pkg/entrypoint.sh /psql/

ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]