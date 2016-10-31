FROM debian:jessie
MAINTAINER Yong Wen Chua <me@yongwen.xyz>

ENV RUST_VERSION=1.12.1

RUN set -x \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
                                          build-essential \
                                          ca-certificates \
                                          curl \
                                          git \
                                          file \
                                          libssl-dev \
    && curl -sSf https://static.rust-lang.org/rustup.sh > /tmp/rustup.sh \
    && chmod +x /tmp/rustup.sh \
    && /tmp/rustup.sh  --disable-sudo --yes --revision="${RUST_VERSION}" \
    && rm /tmp/rustup.sh \
    && apt-get remove -y --auto-remove curl \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /app/src

ENTRYPOINT '/bin/bash'
