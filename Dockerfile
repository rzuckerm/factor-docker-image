FROM ubuntu:22.04

COPY FACTOR_* /tmp/
RUN apt-get update && \
    apt-get install -y wget && \
    mkdir -p /opt/factor && \
    cd /opt/factor && \
    wget https://downloads.factorcode.org/releases/$(cat /tmp/FACTOR_VERSION)/factor-linux-x86-64-$(cat /tmp/FACTOR_VERSION).tar.gz \
        -O factor.tar.gz && \
    tar xzf factor.tar.gz --strip-components=1 factor/factor factor/factor.image && \
    rm -f /bin/factor /usr/bin/factor && \
    cp factor factor.image /usr/local/bin && \
    cd / && \
    rm -rf /opt/factor && \
    apt-get remove -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
