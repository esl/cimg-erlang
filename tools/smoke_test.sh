#!/usr/bin/env bash

set -euo pipefail

compare() {
    NAME=$1
    EXPECTED_VALUE=$2
    ACTUAL_VALUE=$3
    if [ $ACTUAL_VALUE != $EXPECTED_VALUE ]; then
        echo "Incorrect $NAME: $ACTUAL_VALUE instead of $EXPECTED_VALUE"
        exit 1
    else
        echo "Correct $NAME: $ACTUAL_VALUE"
    fi
}

check_erlang() {
    ERL='io:format("~s~n", [filename:join([code:root_dir(), "releases",
                                           erlang:system_info(otp_release), "OTP_VERSION"])]),
         halt().'
    OTP_VERSION_FILE=$(erl -eval "$ERL" -noinput)
    compare "OTP version" "$OTP_VERSION" "$(<$OTP_VERSION_FILE)"
}

check_system_name() {
    case $BASE_IMAGE in
        cimg/base:*)
            compare "OS name" "ubuntu" "$ID"
            ;;
        rockylinux:*)
            compare "OS name" "rocky" "$ID"
            ;;
        *)
            compare "OS name" "${BASE_IMAGE%:*}" "$ID"
            ;;
    esac
}

check_system_version() {
    case $BASE_IMAGE in
        cimg/base:*)
            ;; # version might change, so it is not checked here
        rockylinux:* | almalinux:*)
            compare "OS version" "${BASE_IMAGE#*:}" "${VERSION%.*}"
            ;;
        *)
            compare "OS version" "${BASE_IMAGE#*:}" "$VERSION_CODENAME"
            ;;
    esac
}

check_erlang
source /etc/os-release
check_system_name
check_system_version
