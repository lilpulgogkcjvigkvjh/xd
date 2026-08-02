FROM ubuntu:22.04

# 1. Deshabilitar prompts interactivos en Debian/Ubuntu y CLI
ENV DEBIAN_FRONTEND=noninteractive
ENV CI=true
ENV PYTHONUNBUFFERED=1

# 2. Instalar librerías requeridas por el runtime nativo de Microsoft
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

# 3. Descargar, extraer, otorgar permisos y crear el symlink
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

# 4. Iniciar en modo no interactivo (desconecta el STDIN para que corra únicamente como servicio API)
CMD ["sh", "-c", "foundry run qwen3.5-0.8b < /dev/null"]
