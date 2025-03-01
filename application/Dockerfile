FROM node:18
WORKDIR /application
COPY package.json .
RUN npm install
COPY . .
CMD ["node", "index.js"]