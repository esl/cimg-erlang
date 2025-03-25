#!/usr/bin/env bash
set -euo pipefail

source /tools/utils.sh

compile() {
    ERLANG_DOWNLOAD_URL="https://github.com/erlang/otp/releases/download/OTP-${OTP_VERSION}/otp_src_${OTP_VERSION}.tar.gz"
    mkdir /erlang-src
    cd /erlang-src
    curl -fSL -o erlang.tar.gz "$ERLANG_DOWNLOAD_URL"
    tar -xzf erlang.tar.gz --strip-components=1

    if needs_compiled_openssl; then
        ./configure --with-ssl=/usr/local/ssl
    else
        ./configure
    fi

    make

    mkdir -p /builds
    tar -czf /builds/erlang-${TARGETARCH}.tar.gz /erlang-src
}

install() {
    tar -xzf /builds/erlang-${TARGETARCH}.tar.gz -C /

    cd /erlang-src
    make install

    cd
    rm -rf /erlang-src
}

case ${1:-} in
    compile)
        compile
        ;;
    install)
        install
        ;;
    *)
        echo "Usage: $0 {compile|install}"
        exit 1
        ;;
esac
