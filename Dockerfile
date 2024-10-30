ARG BASE_IMAGE=cimg/base:current
FROM $BASE_IMAGE

ARG BASE_IMAGE
ARG OTP_VERSION
ARG TARGETARCH
ARG USER=root
ENV OTP_VERSION=$OTP_VERSION
ENV ARCH=$TARGETARCH

USER root

RUN --mount=type=bind,src=tools,dst=/tools \
    /tools/prepare.sh build

RUN --mount=type=bind,src=builds,dst=/builds \
    tar -xzf /builds/erlang-$TARGETARCH.tar.gz -C / && \
    cd /erlang-src && \
    make install && \
    cd && \
    rm -rf /erlang-src

RUN --mount=type=bind,src=tools,dst=/tools \
    /tools/smoke_test.sh

USER $USER
