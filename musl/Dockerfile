FROM debian:jessie
MAINTAINER Yong Wen Chua <me@yongwen.xyz>

RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
                                          build-essential \
                                          ca-certificates \
                                          cmake \
                                          curl \
                                          git \
                                          file \
                                          libssl-dev \
                                          libc6-dev \
                                          make \
                                          pkg-config

COPY scripts/xargo.sh /
RUN /xargo.sh

COPY scripts/musl.sh scripts/openssl.sh /
COPY scripts/musl-gcc.x86_64-unknown-linux-musl /usr/local/bin/musl-gcc
COPY /scripts/musl-gcc.specs.x86_64-unknown-linux-musl /usr/local/lib/musl-gcc.specs

ARG MUSL_VERSION=1.1.15
RUN /musl.sh ${MUSL_VERSION} && \
    /openssl.sh linux-x86_64 musl- -static

ENV CC_x86_64_unknown_linux_musl=musl-gcc \
    OPENSSL_DIR=/openssl \
    OPENSSL_INCLUDE_DIR=/openssl/include \
    OPENSSL_LIB_DIR=/openssl/lib

ARG RUST_VERSION=1.17.0
ARG ARCHITECTURE=x86_64-unknown-linux-musl

ENV PATH "/root/.cargo/bin:${PATH}"
RUN set -ex \
    && curl https://sh.rustup.rs -sSf | sh -s -- -y --default-toolchain "${RUST_VERSION}" \
    && rustup target add "${ARCHITECTURE}" \
    && apt-get remove -y --auto-remove curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/src
ENTRYPOINT '/bin/bash'
