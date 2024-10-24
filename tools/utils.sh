#!/usr/bin/env bash

set_up_build() {
    BASE_IMAGE=${BASE_IMAGE:-cimg/base:current}
    BASE_IMAGE_NAME=${BASE_IMAGE%:*}
    BASE_IMAGE_VERSION=${BASE_IMAGE#*:}

    if [ "${BASE_IMAGE%:*}" = "cimg/base" ]; then
        USER=circleci # CircleCI convenience images require a special user
        IMAGE_TAG=cimg-${OTP_VERSION}
    else
        USER=root
        IMAGE_TAG=${BASE_IMAGE_NAME}-${BASE_IMAGE_VERSION}-${OTP_VERSION}
    fi
}
