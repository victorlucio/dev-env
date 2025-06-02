# Usa imagem oficial Node LTS (já tem Node, npm, npx)
FROM node:lts-bullseye

# Variável para evitar prompts
ENV DEBIAN_FRONTEND=noninteractive

# Instalar Java (OpenJDK 17), Python3, Git, etc
RUN apt-get update && \
    apt-get install -y \
    openjdk-17-jdk \
    python3 python3-pip \
    git unzip nano sudo && \
    rm -rf /var/lib/apt/lists/*

# Criar usuário para desenvolvimento
RUN useradd -m devuser && echo "devuser:devpass" | chpasswd && adduser devuser sudo

# Mudar para o usuário devuser
USER devuser
WORKDIR /home/devuser

# Instalar Angular CLI globalmente
RUN npm install -g @angular/cli

# Comando padrão
CMD [ "bash" ]
