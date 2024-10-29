#!/usr/bin/env bash

set -e

if [ $CIRCLE_BRANCH == "master" ]; then
   PUSH="--push"
fi

source tools/utils.sh

set_up_build

docker buildx build --platform linux/amd64,linux/arm64 \
    --build-arg BASE_IMAGE --build-arg OTP_VERSION --build-arg USER \
    -t erlangsolutions/erlang:$IMAGE_TAG \
    --progress=plain -f Dockerfile --provenance=false $PUSH .
