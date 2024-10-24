#!/usr/bin/env bash

set -euo pipefail

export BASE_IMAGE=${BASE_IMAGE:-cimg/base:current}
BASE_IMAGE_NAME=${BASE_IMAGE%:*}
BASE_IMAGE_VERSION=${BASE_IMAGE#*:}

PROGRESS=auto ./compile.sh

if [ "${BASE_IMAGE%:*}" = "cimg/base" ]; then
    USER=circleci # CircleCI convenience images require a special user
    IMAGE_TAG=${OTP_VERSION}
else
    USER=root
    IMAGE_TAG=${BASE_IMAGE_NAME}-${BASE_IMAGE_VERSION}-${OTP_VERSION}
fi

docker build --build-arg BASE_IMAGE --build-arg OTP_VERSION --build-arg USER \
    -t cimg-erlang:$IMAGE_TAG .
