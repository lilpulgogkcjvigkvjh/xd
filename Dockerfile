# Usamos una imagen base oficial de Node.js (Foundry suele correr sobre Node/npm)
FROM node:20-slim

# Instalar dependencias del sistema necesarias (curl, git, etc.)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Instalar Foundry de forma global
RUN npm install -g @foundry/cli || npm install -g foundry-cli

# Crear directorio de trabajo
WORKDIR /app

# Exponer el puerto por defecto si Foundry levanta un servidor de API (ajusta si usas otro puerto)
EXPOSE 8080

# Comando predeterminado para ejecutar el modelo
CMD ["foundry", "run", "qwen3.5-0.8b"]
