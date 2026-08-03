FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true

# 1. Instalar dependencias del sistema requeridas por el motor de Microsoft (.NET Runtime)
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    libicu70 \
    libssl3 \
    zlib1g \
    libgcc-s1 \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar e instalar Foundry Local
RUN mkdir -p /opt/foundry \
    && curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && tar -xzf foundry.tar.gz -C /opt/foundry \
    && chmod -R 777 /opt/foundry \
    && EXECUTABLE=$(find /opt/foundry -type f -name "foundry" | head -n 1) \
    && ln -s "$EXECUTABLE" /usr/local/bin/foundry \
    && rm foundry.tar.gz

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

# 3. Descargar el modelo e iniciar el daemon de API expuesto en 0.0.0.0:$PORT
CMD ["sh", "-c", "foundry model download qwen3.5-0.8b && DAEMON=$(find /opt/foundry -type f -name 'foundrylocald' | head -n 1) && export ASPNETCORE_URLS=http://0.0.0.0:${PORT:-8080} && exec $DAEMON --host 0.0.0.0 --port ${PORT:-8080}"]
