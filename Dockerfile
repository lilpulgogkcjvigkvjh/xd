FROM ubuntu:22.04

# 1. Instalar paquetes esenciales del sistema
RUN apt-get update && apt-get install -y \
    curl \
    tar \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Descargar e instalar el binario oficial de Foundry Local CLI 0.10.0
RUN curl -fsSL https://github.com/microsoft/foundry-local/releases/download/cli-preview-0.10.0/foundry-0.10.0-linux-x64.tar.gz -o foundry.tar.gz \
    && tar -xzf foundry.tar.gz -C /usr/local/bin \
    && rm foundry.tar.gz \
    && chmod +x /usr/local/bin/foundry

WORKDIR /app

# 3. Configurar variables de entorno para Railway
ENV PORT=8080
EXPOSE 8080

# 4. Iniciar el servicio con el modelo deseado
CMD ["foundry", "run", "qwen3.5-0.8b"]
