#!/usr/bin/env bash

set -euo pipefail

source /tools/utils.sh

prepare() {
    MODE=$1
    EXTRA_PACKAGES=${2:-}
    case $BASE_IMAGE in
        ubuntu:* | debian:* | cimg/base:*)
            apt-get update
            apt-get install -y --no-install-recommends \
                libncurses5-dev unixodbc-dev make gcc g++ curl ca-certificates libssl-dev \
                $EXTRA_PACKAGES
            if [ "$MODE" = "compile" ] && needs_compiled_openssl; then
                apt-get install -y --no-install-recommends build-essential zlib1g-dev
            fi
            ;;
        rockylinux:8 | almalinux:8)
            dnf update -y
            dnf install -y unixODBC-devel make gcc gcc-c++ openssl openssl-devel ncurses-devel \
                $EXTRA_PACKAGES
            if [ "$MODE" = "compile" ] && needs_compiled_openssl; then
                dnf install -y zlib-devel
                dnf groupinstall -y "Development Tools"
            fi
            ;;
        rockylinux:9 | almalinux:9)
            dnf update -y
            dnf install -y 'dnf-command(config-manager)'
            dnf config-manager --set-enabled crb
            dnf install -y unixODBC-devel make gcc gcc-c++ openssl openssl-devel ncurses-devel \
                $EXTRA_PACKAGES
            ;;
        *)
            echo "Uknown base image: $BASE_IMAGE"
            exit 1
            ;;
    esac
}

case ${1:-} in
    "compile")
        prepare "compile" "perl"
        ;;
    "build")
        prepare "build"
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
