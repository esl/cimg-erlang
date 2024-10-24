#!/usr/bin/env bash

set -euo pipefail

prepare_compile() {
    case ${BASE_IMAGE%:*} in
        "ubuntu" | "debian" | "cimg/base")
            apt-get update
            apt-get install -y --no-install-recommends \
                    libncurses5-dev unixodbc-dev make gcc g++ perl curl ca-certificates libssl-dev
            ;;
        "rockylinux" | "almalinux")
            yum install -y epel-release
            yum install -y unixODBC-devel make gcc gcc-c++ openssl openssl-devel perl ncurses-devel
            ;;
        *)
            echo "Uknown base image: $BASE_IMAGE"
            exit 1
            ;;
    esac
}

prepare_build() {
    case ${BASE_IMAGE%:*} in
        "ubuntu" | "debian" | "cimg/base")
            apt-get update
            apt-get install -y --no-install-recommends \
                libncurses5-dev unixodbc-dev make gcc g++ curl ca-certificates libssl-dev
            ;;
        "rockylinux" | "almalinux")
            yum install -y epel-release
            yum install -y unixODBC-devel make gcc gcc-c++ openssl openssl-devel ncurses-devel
            ;;
        *)
            echo "Uknown base image: $BASE_IMAGE"
            exit 1
            ;;
    esac
}

case ${1:-} in
    "compile")
        prepare_compile
        ;;
    "build")
        prepare_build
        ;;
    "")
        echo "Missing command"
        exit 2
        ;;
    *)
        echo "Unknown command: $1"
        exit 3
        ;;
esac
