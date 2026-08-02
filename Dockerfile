FROM ubuntu:22.04

# 1. Instalar librerías requeridas por el motor nativo de Microsoft (.NET Runtime / ICU / SSL)
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

# 2. Descargar, extraer y otorgar permisos de ejecución completos a la carpeta y librerías
RUN mkdir -p /opt/foundry \
    && curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && tar -xzf foundry.tar.gz -C /opt/foundry \
    && chmod -R 777 /opt/foundry \
    && EXECUTABLE=$(find /opt/foundry -name "foundry" -type f ! -path "*/lib/*") \
    && ln -s "$EXECUTABLE" /usr/local/bin/foundry \
    && rm foundry.tar.gz

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

CMD ["foundry", "run", "qwen3.5-0.8b"]
