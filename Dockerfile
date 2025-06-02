FROM ubuntu:22.04

# Instalar dependências
RUN apt-get update && \
    apt-get install -y curl bash ca-certificates && \
    rm -rf /var/lib/apt/lists/*
    
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    software-properties-common \
    nano \
    sudo \
    bash

RUN apt-get install -y python3 python3-pip
RUN apt-get install -y openjdk-17-jdk

# Baixar o script do nvm e instalar
RUN curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh -o /tmp/install-nvm.sh && \
    bash /tmp/install-nvm.sh && \
    rm /tmp/install-nvm.sh

# Variáveis de ambiente do nvm
ENV NVM_DIR=/root/.nvm
RUN echo "export NVM_DIR=\"$NVM_DIR\"" >> /root/.bashrc && \
    echo "[ -s \"$NVM_DIR/nvm.sh\" ] && \. \"$NVM_DIR/nvm.sh\"" >> /root/.bashrc

RUN useradd -m devuser && echo "devuser:devpass" | chpasswd && adduser devuser sudo
RUN mkdir -p /home/devuser/.nvm && chown -R devuser:devuser /home/devuser/.nvm

USER devuser
WORKDIR /home/devuser

RUN bash -c "source /home/devuser/.nvm/nvm.sh && nvm install --lts && nvm use --lts && npm install -g @angular/cli"

CMD [ "bash" ]
