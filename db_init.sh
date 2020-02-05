#!/bin/bash
psql postgresql://${USER}:${PASSWORD}@postgre-squash/${DATABASE} -c "select*from project;" 
if [ ! $? == 0 ]
then
    psql postgresql://${USER}:${PASSWORD}@postgre-squash/${DATABASE} -f /squash-tm/database-scripts/postgresql-full-install-version-1.21.0.RELEASE.sql
fi
./startup.sh