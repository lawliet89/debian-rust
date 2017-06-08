# docker-rust

A Docker image that allows building of Rust applications for Linux machines.

The image comes out of the box with support for `x86_64-unknown-linux-musl` and `x86_64-unknown-linux-gnu`
target triple. The default target is `x86_64-unknown-linux-gnu`.

This is published on [Dockerhub](https://hub.docker.com/r/lawliet89/docker-rust/).

## Tags

- `1.17.0`, `v1.7.0`, `latest` ([`Dockerfile`](https://github.com/lawliet89/docker-rust/blob/master/Dockerfile))

## Usage

[Multi-stage builds](https://docs.docker.com/engine/userguide/eng-image/multistage-build/) are recommended
so that the final image will be as small and compact as possible. This is demonstrated in the examples below.

### Target `x86_64-unknown-linux-gnu`

```dockerfile
FROM lawliet89/docker-rust:1.17.0 as builder

WORKDIR /app/src
COPY Cargo.toml Cargo.lock ./
RUN cargo fetch --locked -v

COPY ./ ./
RUN cargo build --release -v --frozen

# Runtime Image

FROM alpine:3.5
WORKDIR /app
COPY --from=builder /app/src/target/release/your_application_name_here .
CMD [/app/your_application_name_here]

```



### Target `x86_64-unknown-linux-musl`

```dockerfile
FROM lawliet89/docker-rust:1.17.0 as builder

ARG ARCHITECTURE=x86_64-unknown-linux-musl
WORKDIR /app/src
COPY Cargo.toml Cargo.lock ./
RUN cargo fetch --locked -v

COPY ./ ./
RUN cargo build --release --target "${ARCHITECTURE}" -v --frozen

# Runtime Image

FROM alpine:3.5
ARG ARCHITECTURE=x86_64-unknown-linux-musl
WORKDIR /app
COPY --from=builder /app/src/target/${ARCHITECTURE}/release/your_application_name_here .
CMD [/app/your_application_name_here]
```
