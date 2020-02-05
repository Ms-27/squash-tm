# Utilisation de la Dockerfile

Pour utiliser l'image squash-tm il faut au préalable instancier la BDD suivante:

    - sudo docker run --name postgre-squash --rm  -e POSTGRES_DB=squashtm -e POSTGRES_USER=squash-tm -e POSTGRES_PASSWORD=initial_pw -d postgres:9.6

On instancie ensuite un conteneur squash

    - sudo docker run --name squash-tm --rm --link postgre-squash squashtm
