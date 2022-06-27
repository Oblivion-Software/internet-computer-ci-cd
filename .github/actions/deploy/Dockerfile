FROM ubuntu:focal

COPY deploy.sh /home/deploy.sh

ENV \ 
    TZ=Europe \
    DEBIAN_FRONTEND=noninteractive

RUN \
    apt -yq update && \
    apt -yqq install --no-install-recommends curl ca-certificates build-essential cmake python3

ARG rust_version=1.54.0
ENV RUSTUP_HOME=/opt/rustup \
    CARGO_HOME=/opt/cargo \
    PATH=/opt/cargo/bin:$PATH
RUN curl --fail https://sh.rustup.rs -sSf \
        | sh -s -- -y --default-toolchain ${rust_version}-x86_64-unknown-linux-gnu --no-modify-path && \
    rustup default ${rust_version}-x86_64-unknown-linux-gnu && \
    rustup target add wasm32-unknown-unknown

ENV DFX_VERSION=0.10.0
RUN sh -ci "$(curl -fsSL https://smartcontracts.org/install.sh)"

RUN cargo install ic-cdk-optimizer

COPY . /canister
WORKDIR /canister

RUN ["chmod", "+x", "/home/deploy.sh"]
ENTRYPOINT ["/home/deploy.sh"]