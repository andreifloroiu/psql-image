#!/bin/sh
set -e

if [ -z "$PSQL_CONNECTION_STRING" ]
    echo "Empty psql connection string"
    psql --help
    exit 0
fi
if [ -z "$PSQL_SCRIPT" ]
    if [ -z "$PSQL_SCRIPT_FILE" ]
        psql $PSQL_CONNECTION_STRING -f script.sql
        exit 0
    fi
    psql $PSQL_CONNECTION_STRING -f $PSQL_SCRIPT_FILE
    exit 0
fi
psql $PSQL_CONNECTION_STRING -c $PSQL_SCRIPT 
