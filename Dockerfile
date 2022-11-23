ARG ALPINE_TAG=latest

FROM alpine:$ALPINE_TAG

## Single connection string - using this will ignore the rest of connection parameters
ENV PSQL_CONNECTION_STRING=
## Default input script file name script.sh
ENV PSQL_SCRIPT_FILE=script.sh
## SQL string to execute instead of script file
ENV PSQL_SCRIPT=
## DB host
ENV PSQL_HOST=
## DB post
ENV PSQL_PORT=
## DB SSL mode
ENV PSQL_SSLMODE=prefer
## DB user
ENV PSQL_USER=
## DB user password
ENV PSQL_PASSWORD=
## DB name
ENV PSQL_DBNAME=

RUN apk update && apk --no-cache add postgresql-client

WORKDIR /psql

COPY pkg/entrypoint.sh /psql/

ENTRYPOINT [ "/bin/sh", "entrypoint.sh" ]