ARG BASE_VERSION=current
FROM cimg/base:$BASE_VERSION

ARG OTP_VERSION
ARG TARGETARCH
ENV OTP_VERSION=$OTP_VERSION
ENV ARCH=$TARGETARCH

RUN sudo apt-get update && sudo apt-get install -y --no-install-recommends \
    libncurses5-dev \
    unixodbc-dev

RUN --mount=type=bind,source=builds/erlang-$TARGETARCH.tar.gz,target=erlang-$TARGETARCH.tar.gz \
    tar -xzf erlang-$TARGETARCH.tar.gz -C ~ && \
    cd ~/erlang-src && \
    sudo make install && \
    cd && \
    rm -rf erlang-src
