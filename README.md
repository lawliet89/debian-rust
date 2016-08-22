# debian-rust
A Debian image with Rust installed to compile and run Rust applications

This is published on [Dockerhub](https://hub.docker.com/r/lawliet89/debian-rust/).

## Tags
 - `1.11.0`, `latest` ([`Dockerfile`](https://github.com/lawliet89/debian-rust/blob/master/Dockerfile))

## Usage
An example Dockerfile might be:

```Dockerfile
FROM lawliet89/debian-rust:1.11.0

COPY Cargo.toml Cargo.lock ./
RUN cargo fetch

COPY . ./
RUN cargo build --release

ENTRYPOINT ["cargo"]
CMD ["run", "--release"]
```
