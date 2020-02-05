#!/bin/bash

docker run --name postgre-squash --rm  -e POSTGRES_DB=squashtm -e POSTGRES_USER=squash-tm -e POSTGRES_PASSWORD=initial_pw -d postgres:9.6

## Ancienne version:
# ip_adr=$(docker inspect postgre-squash | grep -m1 \"IPAddress\" | sed 's/^.\{26\}//g' | sed 's/.\{2\}$//')
# ou
# ip_adr=$(docker inspect postgre-squash | jq -r .[0].NetworkSettings.IPAddress)

# echo "${ip_adr}      postgre-squash" >> /etc/hosts

# psql -h postgre-squash -U squashtm squashtm -f ~/squash-tm/database-scripts/postgresql-full-install-version-1.21.0.RELEASE.sql (mais demande le mdp)
# ou
# psql postgresql://squash-tm:initial_pw@postgre-squash/squashtm -f /home/formation/squash-tm/database-scripts/postgresql-full-install-version-1.21.0.RELEASE.sql
##

docker run --name squash-tm --rm --link postgre-squash squashtm