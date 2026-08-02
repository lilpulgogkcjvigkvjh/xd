FROM ubuntu:22.04

# 1. Instalar paquetes esenciales del sistema
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar, extraer dinámicamente y mover los binarios
RUN curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && mkdir -p /tmp/foundry \
    && tar -xzf foundry.tar.gz -C /tmp/foundry \
    && cp -r /tmp/foundry/* /usr/local/bin/ \
    && rm -rf foundry.tar.gz /tmp/foundry \
    && chmod +x /usr/local/bin/*

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

CMD ["foundry", "run", "qwen3.5-0.8b"]
