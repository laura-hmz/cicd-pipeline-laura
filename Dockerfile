FROM node:18

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

# Instala el servidor estático de manera correcta
RUN npm install -g serve

EXPOSE 3000

# Usamos el binario directamente desde npx (más seguro)
CMD ["npx", "serve", "-s", "build", "-l", "3000"]
