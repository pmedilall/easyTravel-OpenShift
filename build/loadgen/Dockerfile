FROM alpine:3.3

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>, Rafal Psciuk <rafal.psciuk@dynatrace.com>

ENV ET_HOME /easytravel
ENV ET_RUNTIME_DEPS "openjdk8-jre-base"
RUN apk add --no-cache ${ET_RUNTIME_DEPS}
ADD build/loadgen.tar.gz ${ET_HOME}

ENV ET_USER et

# Create a user and group used to launch processes
RUN addgroup -S ${ET_USER} && \
    adduser -h ${ET_HOME} -G ${ET_USER} -S -D -h /home/${ET_USER} ${ET_USER} && \
    chmod 755 ${ET_HOME} && \
    chown -R ${ET_USER}:${ET_USER} ${ET_HOME}

ENV JAVA_OPTS="-Duser.home=/home/et"

WORKDIR ${ET_HOME}

USER ${ET_USER}

CMD java ${JAVA_OPTS} -jar uemload.jar --autorun true --server ${ET_FRONTEND_URL}