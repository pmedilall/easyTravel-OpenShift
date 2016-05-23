FROM jeanblanchard/tomcat:8

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>, Rafal Psciuk <rafal.psciuk@dynatrace.com>

ENV TOMCAT_HOME /opt/apache-tomcat-${TOMCAT_VERSION_FULL}

# Make Tomcat folder structure accessible
RUN chmod -R 644 ${TOMCAT_HOME}/conf/* && \
    chmod 777 ${TOMCAT_HOME}/logs ${TOMCAT_HOME}/temp ${TOMCAT_HOME}/webapps ${TOMCAT_HOME}/work

# Deploy easyTravel Customer Frontend Application
COPY build/frontend.war ${TOMCAT_HOME}/webapps/

# The Tomcat Manager can be access using '/tomcat' context
RUN mv ${TOMCAT_HOME}/webapps/ROOT ${TOMCAT_HOME}/webapps/tomcat

# Make easyTravel Business Backend application base '/' context
RUN mv ${TOMCAT_HOME}/webapps/frontend.war ${TOMCAT_HOME}/webapps/ROOT.war

ENV ET_USER et

# Create a user and group used to launch processes
RUN addgroup -S ${ET_USER} && \
    adduser -h ${TOMCAT_HOME} -G ${ET_USER} -S -D -h /home/${ET_USER} ${ET_USER} && \
    chmod 755 ${TOMCAT_HOME} && \
    chown -R ${ET_USER}:${ET_USER} ${TOMCAT_HOME}

ENV JAVA_OPTS="-Duser.home=/home/et"

WORKDIR ${TOMCAT_HOME}

USER ${ET_USER}