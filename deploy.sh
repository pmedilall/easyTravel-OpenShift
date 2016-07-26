#!/bin/bash

set -e

. ./config/os-settings.sh

oc login https://${OS_MASTER_IP}:8443 --username=admin --password=admin
oc create -f templates/dynatrace-easytravel.yml
oc new-app dynatrace-easytravel