FROM ubuntu:22.04

# Instalar dependencias base de Linux y curl
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar la CLI de Foundry Local desde su repositorio u origen oficial
# (Sustituye la URL por la URL del instalador/binario Linux de Foundry que utilices)
RUN curl -fsSL https://raw.githubusercontent.com/microsoft/foundry-local/main/install.sh | bash || true

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

CMD ["foundry", "run", "qwen3.5-0.8b"]
