#!/usr/bin/env bash

set -e

if [ $CIRCLE_BRANCH == "master" ]; then
   PUSH="--push"
fi

docker buildx build --platform linux/amd64,linux/arm64 \
  --build-arg OTP_VERSION -t mongooseim/cimg-erlang:$OTP_VERSION \
  --progress=plain -f Dockerfile $PUSH .
