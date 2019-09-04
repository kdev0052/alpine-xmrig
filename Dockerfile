FROM nvidia/cuda:lastest

RUN apt-get update \
    && set -x \
    && apt-get install -qq --no-install-recommends -y build-essential ca-certificates cmake cuda-core-9-0 git cuda-cudart-dev-9-0 libhwloc-dev libmicrohttpd-dev libssl-dev \
    && git clone https://github.com/kdev0052/xmri \
    && cd xmrig \
    && mkdir build \
    && cmake -DCMAKE_BUILD_TYPE=Release . \
    && make \ 
    && cd - \
    && mv /xmrig/bin/* /usr/local/bin/ \
    && rm -rf /xmrig \
    && apt-get purge -y -qq build-essential cmake cuda-core-9-0 git cuda-cudart-dev-9-0 libhwloc-dev libmicrohttpd-dev libssl-dev \
    && apt-get clean -qq

VOLUME /mnt
WORKDIR /mnt

ENTRYPOINT ["/usr/local/bin/xmrig"]
