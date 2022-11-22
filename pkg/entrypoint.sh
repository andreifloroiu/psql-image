#!/bin/sh
set -e


if [ -z "$PSQL_CONNECTION_STRING" ]
then
    if [ ! -z "$PSQL_HOST" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING host=$PSQL_HOST"
    fi
    if [ ! -z "$PSQL_PORT" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING port=$PSQL_PORT"
    fi
    if [ ! -z "$PSQL_SSLMODE" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING sslmode=$PSQL_SSLMODE"
    fi
    if [ ! -z "$PSQL_USER" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING user=$PSQL_USER"
    fi
    if [ ! -z "$PSQL_PASSWORD" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING password=$PSQL_PASSWORD"
    fi
    if [ ! -z "$PSQL_DBNAME" ]
    then
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING sslmode=$PSQL_DBNAME"
    fi
fi

if [ -z "$PSQL_SCRIPT" ]
then
    if [ -z "$PSQL_SCRIPT_FILE" ]
    then
        psql "$PSQL_CONNECTION_STRING" -f script.sql
        exit 0
    fi
    psql "$PSQL_CONNECTION_STRING" -f $PSQL_SCRIPT_FILE
    exit 0
fi

psql "$PSQL_CONNECTION_STRING" -c "$PSQL_SCRIPT" \
    || psql --help && exit 1