# Copies in our code and runs NPM Install
FROM node:latest as builder
RUN cd /tmp && \
    git clone https://github.com/ExpediaInceCommercePlatform/cyclotron && \
    mkdir -p /opt/app && \
    mv cyclotron/cyclotron-site /opt/app/ && \
    rm -rf /tmp/cyclotron
WORKDIR /opt/app/cyclotron-site
RUN npm install -g bower gulp && \
    npm install
RUN ["gulp", "vendor"]
RUN ["gulp", "build"]

# Lints Code
FROM node:latest as linting
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "lint"]

# Runs Unit Tests
FROM node:latest as unit-tests
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "test"]

# Runs Minify
FROM node:latest as minifier
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "minify"]

# Production
FROM nginx:stable-alpine as production
LABEL maintainer="Floiran JUDITH <florian.judith.b@gmail.com>"

COPY asset/nginx.conf /etc/nginx/conf.d/cyclotron-site.conf
COPY asset/cyclotron-site.config.js /opt/app/cyclotron-site/_public/js/conf/configService.js
COPY --from=builder /opt/app/cyclotron-site /opt/app/cyclotron-site

EXPOSE 8088

CMD ["nginx", "-g", "daemon off;"]