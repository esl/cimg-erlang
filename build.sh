#!/usr/bin/env bash

set -euo pipefail

source tools/utils.sh

./compile.sh

set_up_build

docker build --build-arg BASE_IMAGE --build-arg OTP_VERSION --build-arg USER \
    -t cimg-erlang:$IMAGE_TAG .
