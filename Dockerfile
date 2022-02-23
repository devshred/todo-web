# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/default.conf conf/gzip.conf /etc/nginx/conf.d/

# Set permissions
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && \
    chgrp -R root /var/cache/nginx && \
    chmod -R go+w /usr/share/nginx/

COPY set_environment.sh /docker-entrypoint.d/

RUN chmod 755 /docker-entrypoint.d/set_environment.sh



COPY --from=build-stage /app/dist /usr/share/nginx/original
