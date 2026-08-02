FROM python:3.11-slim

# 1. Instalar dependencias esenciales del sistema operativo
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalar el SDK oficial de Python
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir foundry-local-sdk

# 3. Descargar e instalar los ejecutables nativos de la CLI (foundry)
RUN foundry-local-install --verbose

# 4. Registrar la ruta de binarios de Linux en las variables de entorno
ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

# 5. Ejecutar directamente con la CLI de foundry
CMD ["foundry", "run", "qwen3.5-0.8b"]
