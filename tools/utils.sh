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

needs_compiled_openssl() {
    OS_ID=$(grep ^ID= /etc/os-release | cut -d= -f2 | tr -d '"')
    OS_VERSION=$(grep ^VERSION_ID= /etc/os-release | cut -d= -f2 | tr -d '"' | cut -d. -f1)

    if { [ "$OS_ID" = "ubuntu" ] && [ "$OS_VERSION" -lt 22 ]; } || \
       { [ "$OS_ID" = "debian" ] && [ "$OS_VERSION" -lt 11 ]; } || \
       { [ "$OS_ID" = "rocky" ] && [ "$OS_VERSION" -lt 9 ]; } || \
       { [ "$OS_ID" = "almalinux" ] && [ "$OS_VERSION" -lt 9 ]; }; then
        return 0
    else
        return 1
    fi
}
