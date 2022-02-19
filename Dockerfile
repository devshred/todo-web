# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY set_environment.sh /docker-entrypoint.d/.
RUN chmod 777 /docker-entrypoint.d/set_environment.sh
RUN chmod 666 /usr/share/nginx/html/environment.js
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]