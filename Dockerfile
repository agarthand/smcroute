FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    libnl-3-dev libnl-genl-3-dev libnl-route-3-dev \
    iproute2 \
    && rm -rf /var/lib/apt/lists/*

COPY . /smcroute
WORKDIR /smcroute

RUN make && make install

EXPOSE 2262/udp

ENTRYPOINT ["smcroute", "-d", "-f", "/etc/smc/smcroute.conf"]
