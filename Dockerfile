FROM node:alpine

WORKDIR '/app'

COPY package.json ./
COPY package-lock.json ./

RUN npm config set unsafe-perm true
RUN npm install --silent

COPY . .

RUN chown -R node /app/node_modules

USER node

RUN npm run build

FROM nginx
COPY --from=0 /app/build /usr/share/nginx/html