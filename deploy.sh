#!/bin/bash

set -e

. ./config/os-settings.sh

oc login https://${OS_MASTER_IP}:8443 --username=admin --password=admin

oc new-project easytravel || true
oc new-app dynatrace/easytravel-mongodb:openshift
oc new-app dynatrace/easytravel-backend:openshift --env ET_DATABASE_LOCATION=easytravel-mongodb:27017
oc new-app dynatrace/easytravel-frontend:openshift --env ET_BACKEND_URL='http://easytravel-backend:8080'