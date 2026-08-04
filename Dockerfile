FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true

# 1. Instalar dependencias del sistema y socat para el reenvío de red
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    libicu70 \
    libssl3 \
    zlib1g \
    libgcc-s1 \
    libstdc++6 \
    socat \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar e instalar Foundry Local CLI
RUN mkdir -p /opt/foundry \
    && curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && tar -xzf foundry.tar.gz -C /opt/foundry \
    && chmod -R 777 /opt/foundry \
    && EXECUTABLE=$(find /opt/foundry -type f -name "foundry" | head -n 1) \
    && ln -s "$EXECUTABLE" /usr/local/bin/foundry \
    && rm foundry.tar.gz

WORKDIR /app
COPY start.sh /app/start.sh

ENV PORT=8080
EXPOSE 8080

# 3. Descargar el modelo, iniciar el daemon en el puerto interno 3000 y mapear con socat al $PORT de Railway
CMD ["/app/start.sh"]
