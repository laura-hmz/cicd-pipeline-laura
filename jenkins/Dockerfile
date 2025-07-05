# jenkins/Dockerfile
FROM jenkins/jenkins:lts

USER root

# Instalar Docker dentro del contenedor
RUN apt-get update && \
    apt-get install -y docker.io curl gnupg && \
    usermod -aG docker jenkins

# Instalar Node.js 18 y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm

# Verificar que se instaló correctamente
RUN node -v && npm -v

USER jenkins
