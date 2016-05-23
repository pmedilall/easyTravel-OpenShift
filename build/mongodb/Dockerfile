FROM alpine:edge

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>, Rafal Psciuk <rafal.psciuk@dynatrace.com>

ENV MONGODB_DB /data/db/easyTravel
ENV MONGODB_USER mongodb

RUN echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk add --no-cache mongodb && \
    chown ${MONGODB_USER}:${MONGODB_USER} /usr/bin/mongo*

# Deploy easyTravel database
ADD build/easyTravel-mongodb-db-noauth.tar.gz ${MONGODB_DB}
RUN chown -R ${MONGODB_USER}:${MONGODB_USER} ${MONGODB_DB}

VOLUME ${MONGODB_DB}

EXPOSE 27017 28017

USER ${MONGODB_USER}

CMD mongod --rest --httpinterface --smallfiles --dbpath ${MONGODB_DB}