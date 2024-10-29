#!/usr/bin/env bash

set -euo pipefail

docker build --progress=${PROGRESS:-auto} --build-arg BASE_IMAGE --build-arg OTP_VERSION \
    -t cimg-erlang-builder -f Dockerfile-compile .
BUILDER=`docker create cimg-erlang-builder`
docker cp $BUILDER:builds .
docker rm $BUILDER
