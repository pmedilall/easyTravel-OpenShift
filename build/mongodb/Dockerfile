FROM alpine:edge

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>, Rafal Psciuk <rafal.psciuk@dynatrace.com>

ENV MONGODB_DB /data/db/easyTravel
ENV MONGODB_USER 100
ENV MONGODB_GROUP 101

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --no-cache mongodb && \
    chown ${MONGODB_USER}:${MONGODB_USER} /usr/bin/mongo*

EXPOSE 27017 28017

# Deploy easyTravel database
RUN mkdir -p ${MONGODB_DB} && \
    chmod 777 ${MONGODB_DB}

ADD build/easyTravel-mongodb-db.tar.gz /tmp/db
RUN chmod -R 777 /tmp/db

VOLUME ${MONGODB_DB}

USER ${MONGODB_USER}

CMD mv /tmp/db/* ${MONGODB_DB} && mongod --rest --httpinterface --smallfiles --dbpath ${MONGODB_DB}