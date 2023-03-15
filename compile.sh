#!/usr/bin/env bash

set -e

docker build --progress=plain --build-arg BASE_VERSION --build-arg OTP_VERSION \
    -t cimg-erlang-builder -f Dockerfile-compile .
BUILDER=`docker create cimg-erlang-builder`
docker cp $BUILDER:/home/circleci/builds .
docker rm $BUILDER
