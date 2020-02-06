# Utilisation de la Dockerfile

Pour utiliser l'image squash-tm il faut au préalable créer un volume:

    sudo docker volume create DB_backup

On instancier la BDD suivante :

    sudo docker run --name postgre-squash --rm --mount source=DB_backup,target=/var/lib/postgresql/data \
    -e POSTGRES_DB=squashtm -e POSTGRES_USER=squash-tm -e POSTGRES_PASSWORD=initial_pw -d postgres:9.6

On instancie ensuite un conteneur squash

    sudo docker run --name squash-tm --rm --link postgre-squash \
    -e DATABASE=squashtm -e USER=squashtm -e PASSWORD=initial_pw -d squashtm
