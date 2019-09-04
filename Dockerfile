FROM  babim/alpinebase
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        libmicrohttpd-dev \
	openssl-dev \
        build-base && \
      git clone https://github.com/kdev0052/xmrig && mv xmrig xmrig-dev && \
      cd xmrig-dev && cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && mv xmrig / && cd ../ && rm -rf xmrig-dev && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /
ENTRYPOINT  ["./xmrig", "--donate-level=1"]
