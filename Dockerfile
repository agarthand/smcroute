# Dockerfile für smcroute basierend auf Debian slim

FROM debian:bookworm-slim

# Installiere alle nötigen Build-Tools und Abhängigkeiten
RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    autoconf \
    automake \
    libtool \
    pkg-config \
    iproute2 \
    iputils-ping \
    && rm -rf /var/lib/apt/lists/*

# Hole den aktuellen Quellcode von smcroute
RUN git clone https://github.com/troglobit/smcroute.git /smcroute

WORKDIR /smcroute

# Build-Schritte für smcroute
RUN ./autogen.sh && ./configure && make && make install

# Erstelle Standard-Konfigurationsordner, kann durch Volume ersetzt werden
RUN mkdir -p /etc/smcroute

# Standard Kommando, laufe im Vordergrund mit config-Datei (kann angepasst werden)
CMD ["smcroute", "-f", "-c", "/etc/smcroute/smcroute.conf"]
