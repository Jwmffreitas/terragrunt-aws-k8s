FROM node:18-alpine
WORKDIR /application
COPY package.json .
RUN npm install
COPY . .
CMD ["node", "index.js"]