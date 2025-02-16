FROM  arm64v8/alpine
RUN   adduser -S -D -H -h /cpuminer-multi miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        automake \
        autoconf \
        openssl-dev \
        curl-dev \
        git \
        build-base && \
      git clone https://github.com/tpruvot/cpuminer-multi && \
      cd cpuminer-multi && \
        ./autogen.sh && \
        CFLAGS="-O3 -march=native" ./configure && \
        make && \
      apk del \
        automake \
        autoconf \
        build-base \
        git
USER miner
WORKDIR    /cpuminer-multi
ENTRYPOINT  ["./minerd"]
