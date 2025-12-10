FROM python:3.11-slim

LABEL maintainer="thiago@local"

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /work

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    netcat-openbsd \
    iputils-ping \
    tcpdump \
    vim \
    ca-certificates \
    curl \
    gnupg2 \
    dirmngr \
    && rm -rf /var/lib/apt/lists/*

# Install gosu for drop-to-user (safer execution)
RUN set -eux; \
    dpkgArch="$(dpkg --print-architecture)"; \
    curl -o /usr/local/bin/gosu -L "https://github.com/tianon/gosu/releases/download/1.16/gosu-${dpkgArch}"; \
    chmod +x /usr/local/bin/gosu

# Instala pwntools
RUN pip install --no-cache-dir pwntools

# Copia entrypoint e garante conversão de CRLF -> LF
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN sed -i 's/\r$//' /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/bin/bash"]
