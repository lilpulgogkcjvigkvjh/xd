FROM python:3.11-slim

# 1. Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalar el SDK oficial de Python de Foundry Local
RUN pip install --no-cache-dir foundry-local-sdk

WORKDIR /app

# 3. Railway asigna dinámicamente un puerto en la variable PORT
ENV PORT=8080
EXPOSE 8080

# 4. Ejecutar el modelo con el CLI de Foundry Local
CMD ["foundry", "run", "qwen3.5-0.8b"]
