FROM openjdk:8
LABEL maintainer="oborde@henix.fr"

ARG SQUASH_VERSION=1.21.0

# ARG est pour le build, mais on a besoin de la valeur pour le run donc:
ENV SQUASH_VERSION ${SQUASH_VERSION}   

ENV USER squash-tm
ENV PASSWORD initial_pw
ENV DATABASE squashtm
ENV PORT 5432

EXPOSE 8080

RUN wget http://repo.squashtest.org/distribution/squash-tm-${SQUASH_VERSION}.RELEASE.tar.gz
RUN tar xvf squash-tm-${SQUASH_VERSION}.RELEASE.tar.gz
RUN rm squash-tm-${SQUASH_VERSION}.RELEASE.tar.gz

RUN apt update && apt install -y postgresql-client-9.6
# On modifie le startup.sh avec les paramètres de connexion à la BDD
WORKDIR /squash-tm/bin
RUN sed -i "s/DB_TYPE=h2/DB_TYPE=postgresql/" startup.sh
RUN sed -i "s!DB_URL=jdbc:h2:../data/squash-tm!DB_URL=jdbc:postgresql://postgre-squash:\${PORT}/\${DATABASE}!" startup.sh
RUN sed -i "s/DB_USERNAME=sa/DB_USERNAME=\${USER}/" startup.sh
RUN sed -i "s/DB_PASSWORD=sa/DB_PASSWORD=\${PASSWORD}/" startup.sh

RUN chmod +x startup.sh

COPY init_and_start.sh .

CMD chmod +x init_and_start.sh ; ./init_and_start.sh