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
        $PSQL_CONNECTION_STRING = "$PSQL_CONNECTION_STRING dbname=$PSQL_DBNAME"
    fi
fi

if [ ! -z "$PSQL_CONNECTION_STRING" ]
then
    if [ -z "$PSQL_SCRIPT" ]
    then
        if [ -z "$PSQL_SCRIPT_FILE" ]
        then
            psql "$PSQL_CONNECTION_STRING" -f /psql/script.sql
        else
            psql "$PSQL_CONNECTION_STRING" -f $PSQL_SCRIPT_FILE
        fi
    else
        psql "$PSQL_CONNECTION_STRING" -c "$PSQL_SCRIPT" \
            || psql --help && exit 1
    fi
fi
