# debian-rust

A Debian image with Rust installed to compile and run Rust applications

This is published on [Dockerhub](https://hub.docker.com/r/lawliet89/debian-rust/).

There are two flavours to the image - `gnu` linked and `musl` linked.

Binaries built with the `gnu` flavour will be linked dynamically with the GNU C Library or `glibc`.
Thus, to run the binarties, the machine will need to have a supported and relatively recent version of `glibc`.

On the other hand, the `musl` flavour will statically link withn the `musl` library and you can run the
binary directly with no other depdendencies.

You might have more issues building with `musl` than with `gnu` because if you crates link against `glibc`, then
you will have to find some ways to link them with `musl` instead.

See [this](https://github.com/japaric/rust-cross) for more information.

## Tags

- `1.17.0`, `latest` ([`Dockerfile`](https://github.com/lawliet89/debian-rust/blob/master/Dockerfile))

## Usage

An example Dockerfile might be:

```Dockerfile
FROM lawliet89/debian-rust:1.17.0

COPY Cargo.toml Cargo.lock ./
RUN cargo fetch

COPY . ./
RUN cargo build --release

ENTRYPOINT ["cargo"]
CMD ["run", "--release"]
```

## Credits

The `musl` linked variant uses scripts from [`cross`](https://github.com/japaric/cross).
