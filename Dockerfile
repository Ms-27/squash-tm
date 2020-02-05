FROM openjdk:8
LABEL maintainer="oborde@henix.fr"

ARG SQUASH_VERSION=squash-tm-1.21.0.RELEASE.tar.gz

ENV USER squash-tm
ENV PASSWORD initial_pw
ENV DATABASE squashtm

EXPOSE 8080

RUN wget http://repo.squashtest.org/distribution/${SQUASH_VERSION}
RUN tar xvf ${SQUASH_VERSION}
RUN rm ${SQUASH_VERSION}

EXPOSE 8080

##
# On peuple la BDD postgre sur le conteneur postgre-squash
RUN apt update
RUN apt install -y postgresql-client-9.6
# On modifie le startup.sh avec les paramètres de connexion à la BDD
WORKDIR /squash-tm/bin
RUN sed -i "s/DB_TYPE=h2/DB_TYPE=postgresql/" startup.sh
RUN sed -i "s!DB_URL=jdbc:h2:../data/squash-tm!DB_URL=jdbc:postgresql://postgre-squash:5432/\${DATABASE}!" startup.sh
RUN sed -i "s/DB_USERNAME=sa/DB_USERNAME=\${USER}/" startup.sh
RUN sed -i "s/DB_PASSWORD=sa/DB_PASSWORD=\${PASSWORD}/" startup.sh
RUN chmod +x startup.sh
##
COPY db_init.sh .

CMD chmod +x db_init.sh ; ./db_init.sh