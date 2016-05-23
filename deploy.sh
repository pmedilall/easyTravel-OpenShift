#!/bin/bash
. ./config/os-settings.sh

oc login https://${OS_MASTER_IP}:8443 --username=admin --password=admin

oc new-app dynatrace/easytravel-mongodb:openshift
oc new-app dynatrace/easytravel-backend:openshift --env ET_DATABASE_LOCATION=easytravel-mongodb:27017 --env CATALINA_OPTS=-Dconfig.mongoDbUser=
oc new-app dynatrace/easytravel-frontend:openshift --env ET_BACKEND_URL=easytravel-backend:8080