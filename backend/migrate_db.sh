#!/bin/bash

#echo "DB_NAME: $DB_NAME"
DB_SOCKET_NAME=$( compgen -A variable | grep _SOCKET)
DB_INSTANCE_NAME=$( compgen -A variable | grep _INSTANCE)

#echo "DB_SOCKET_NAME: $DB_SOCKET_NAME"
#echo "DB_INSTANCE_NAME: $DB_INSTANCE_NAME"

DB_SOCKET=${!DB_SOCKET_NAME}
DB_INSTANCE=${!DB_INSTANCE_NAME}

#echo "DB_SOCKET: $DB_SOCKET"
#echo "DB_INSTANCE: $DB_INSTANCE"

if [[ ${DB_SOCKET} == /* ]]
then
	POSTGRESQL_URL="postgres://${DB_USER}:${DB_PASSWORD}@/${DB_NAME}?host=${DB_SOCKET}"
else
	POSTGRESQL_URL="postgres://${DB_USER}:${DB_PASSWORD}@${DB_INSTANCE}:${DB_PORT}/${DB_NAME}?sslmode=disable"
fi

echo "POSTGRESQL_URL: $POSTGRESQL_URL"

#/app/migrate -path /app/db/migrations -database ${POSTGRESQL_URL} force 1
#/app/migrate -path /app/db/migrations -database ${POSTGRESQL_URL} down -all
/app/migrate -path /app/db/migrations -database ${POSTGRESQL_URL} up


