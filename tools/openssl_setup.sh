#!/usr/bin/env bash
set -euo pipefail

source /tools/utils.sh

compile() {
    if needs_compiled_openssl; then
        echo "Compiling OpenSSL $OPENSSL_VERSION."
        OPENSSL_DOWNLOAD_URL="https://github.com/openssl/openssl/releases/download/openssl-${OPENSSL_VERSION}/openssl-${OPENSSL_VERSION}.tar.gz"
        mkdir /openssl-src
        cd /openssl-src

        curl -fSL -o openssl.tar.gz "$OPENSSL_DOWNLOAD_URL"
        tar -xzf openssl.tar.gz --strip-components=1

        ./config --prefix=/usr/local/ssl --openssldir=/usr/local/ssl shared zlib
        make build_libs -j"$(nproc)"
        make install_sw

        rm -rf /usr/local/ssl/bin/

        mkdir -p /builds
        tar -czf /builds/openssl-${TARGETARCH}.tar.gz -C /usr/local/ssl .
    else
        echo "System OpenSSL is sufficient — skipping build."
    fi
}

install() {
    if needs_compiled_openssl; then
        echo "Extracting bundled OpenSSL."
        mkdir /usr/local/ssl
        tar -xzf /builds/openssl-${TARGETARCH}.tar.gz -C /usr/local/ssl
    else
        echo "No bundled OpenSSL found. Skipping setup."
    fi
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
