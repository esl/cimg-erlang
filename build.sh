#!/usr/bin/env bash

set -e

export OTP_VERSION=${1:-25.2.3}

./compile.sh
docker build --build-arg OTP_VERSION -t cimg-erlang:$OTP_VERSION .
