FROM node:20-slim

# Instalar dependencias esenciales
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Instalar Foundry localmente en el directorio de trabajo para evitar fallos de rutas globales
RUN npm install @foundry/cli || npm install foundry

# Asegurar que Railway exponga el puerto correctamente
ENV PORT=8080
EXPOSE 8080

# Usamos npx para invocar el binario directamente dentro de node_modules
CMD ["npx", "foundry", "run", "qwen3.5-0.8b"]
