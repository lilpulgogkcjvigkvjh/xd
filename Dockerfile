FROM ubuntu:22.04

# 1. Instalar dependencias esenciales
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar, extraer y otorgar permisos RECURSIVOS a todos los binarios y librerías
RUN curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && mkdir -p /opt/foundry \
    && tar -xzf foundry.tar.gz -C /opt/foundry \
    && chmod -R +x /opt/foundry \
    && EXECUTABLE=$(find /opt/foundry -name "foundry" -type f ! -path "*/lib/*") \
    && ln -s "$EXECUTABLE" /usr/local/bin/foundry \
    && rm foundry.tar.gz

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

CMD ["foundry", "run", "qwen3.5-0.8b"]
