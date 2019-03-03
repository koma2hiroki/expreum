FROM ubuntu:18.04 as builder
WORKDIR /workspace/
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y curl build-essential libssl-dev pkg-config && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y

# build dependencies
COPY Cargo.toml .
COPY Cargo.lock .
RUN mkdir src && \
    echo "fn main(){}" > src/main.rs && \
    ~/.cargo/bin/cargo build --release

# build app
COPY ./src/ ./src/
RUN ~/.cargo/bin/cargo build --release


FROM ubuntu:18.04
WORKDIR /root/
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y libssl-dev
COPY --from=builder /workspace/target/release/expreum .

ENTRYPOINT [ "./expreum" ]
