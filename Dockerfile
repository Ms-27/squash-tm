FROM openjdk:8
LABEL maintainer="oborde@henix.fr"

RUN wget http://repo.squashtest.org/distribution/squash-tm-1.21.0.RELEASE.tar.gz
RUN tar xvf squash-tm-1.21.0.RELEASE.tar.gz
RUN rm squash-tm-1.21.0.RELEASE.tar.gz

EXPOSE 8080


WORKDIR /squash-tm/bin
RUN chmod +x startup.sh
CMD ./startup.sh