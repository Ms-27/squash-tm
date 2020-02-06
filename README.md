## Utilisation du Dockerfile


# Version manuelle

On créé un volume pour la BDD:

    sudo docker volume create DB_backup

On instancie la BDD:

    sudo docker run --name postgre-squash --rm --mount source=DB_backup,target=/var/lib/postgresql/data \
    -e POSTGRES_DB=squashtm -e POSTGRES_USER=squash-tm -e POSTGRES_PASSWORD=initial_pw -d postgres:9.6

On instancie ensuite un conteneur squash-tm:

    sudo docker run --name squash-tm --rm --link postgre-squash \
    -e DATABASE=squashtm -e USER=squashtm -e PASSWORD=initial_pw -d squashtm

# Version Auto

On créé un fichier .env à la racine avec:

    DB_USER=squash-tm
    DB_PASSWORD=initial_pw
    DB_DATABASE=squashtm

On éxecute docker-compose.yml

    sudo docker-compose up