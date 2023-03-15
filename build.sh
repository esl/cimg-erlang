#!/usr/bin/env bash

set -e

export OTP_VERSION=${1:-25.3}

./compile.sh
docker build --build-arg BASE_VERSION --build-arg OTP_VERSION \
  -t cimg-erlang:$OTP_VERSION .
