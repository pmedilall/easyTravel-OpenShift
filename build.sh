#!/bin/bash
. ./config/app-settings.sh

export ET_DEPLOY_HOME="./build"
export ET_CF_DEPLOY_HOME="frontend/build"
export ET_BB_DEPLOY_HOME="backend/build"
export ET_LG_DEPLOY_HOME="loadgen/build"

export DOCKER_CONTAINER_BUILD_SH_PREFIX="./app/easyTravel"

./app/easyTravel/build-in-docker.sh

for folder in `ls -d build/*/`; do
  pushd ${folder}
  ./build.sh
  popd
done