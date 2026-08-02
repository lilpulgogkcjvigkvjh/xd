FROM node:20-slim

# Instalar dependencias del sistema requeridas por instaladores/CLI
RUN apt-get update && apt-get install -y \
    curl \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Si Foundry usa su script oficial de instalación (p. ej. via curl):
# RUN curl -fsSL https://... | sh

# Si Foundry es un paquete Node oficial (asegúrate de usar el scope o paquete correcto):
RUN npm install -g @palantir/foundry-cli || npm install -g foundry

WORKDIR /app

# Aseguramos el PATH global de npm en caso de que no esté mapeado
ENV PATH="${PATH}:/usr/local/lib/node_modules/.bin"

CMD ["foundry", "run", "qwen3.5-0.8b"]
