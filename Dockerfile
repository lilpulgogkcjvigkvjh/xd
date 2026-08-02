FROM python:3.11-slim

# 1. Instalar herramientas del sistema requeridas
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 2. Instalar el SDK de Foundry Local y herramientas necesarias
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir foundry-local-sdk

# 3. Forzar las rutas globales de ejecutables de Python al PATH de Linux
ENV PATH="/usr/local/bin:/root/.local/bin:${PATH}"

WORKDIR /app

ENV PORT=8080
EXPOSE 8080

# 4. Invocar el ejecutable asegurando la ruta de Python
CMD ["python", "-m", "foundry_local", "run", "qwen3.5-0.8b"]
