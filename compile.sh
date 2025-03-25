#!/usr/bin/env bash

set -euo pipefail

docker build --progress=${PROGRESS:-auto} --build-arg BASE_IMAGE --build-arg OTP_VERSION \
    --build-arg OPENSSL_VERSION=${OPENSSL_VERSION:-3.0.16} \
    -t cimg-erlang-builder -f Dockerfile-compile .
BUILDER=`docker create cimg-erlang-builder`
docker cp $BUILDER:builds .
docker rm $BUILDER
