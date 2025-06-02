FROM ubuntu:22.04
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

ENV NVM_DIR=/home/devuser/.nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

RUN echo 'export NVM_DIR="$HOME/.nvm"' >> /home/devuser/.bashrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/devuser/.bashrc

RUN useradd -m devuser && echo "devuser:devpass" | chpasswd && adduser devuser sudo
RUN mkdir -p /home/devuser/.nvm && chown -R devuser:devuser /home/devuser/.nvm

USER devuser
WORKDIR /home/devuser

RUN bash -c "source /home/devuser/.nvm/nvm.sh && nvm install --lts && nvm use --lts && npm install -g @angular/cli"

CMD [ "bash" ]
