#!/bin/bash
psql postgresql://${USER}:${PASSWORD}@postgre-squash:${PORT}/${DATABASE} -c "select*from project;" 
if [ ! $? == 0 ] # ou [ $? != 0 ]
then
    psql postgresql://${USER}:${PASSWORD}@postgre-squash:${PORT}/${DATABASE} -f /squash-tm/database-scripts/postgresql-full-install-version-${SQUASH_RELEASE}.RELEASE.sql
fi
./startup.sh