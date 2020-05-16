# Copies in our code and runs NPM Install
FROM node:lts as builder
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
FROM node:lts as linting
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "lint"]

# Runs Unit Tests
FROM node:lts as unit-tests
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "test"]

# Runs Minify
FROM node:lts as minifier
RUN npm install -g gulp
WORKDIR /opt/app/cyclotron-site
COPY --from=builder /opt/app/cyclotron-site .
RUN ["gulp", "minify"]

# Production
FROM nginx:stable-alpine as production

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

ARG USER="cyclotron"
ARG USER_ID="1009"
ARG GROUP="cyclotron"
ARG GROUP_ID="1009"
ARG GOMPLATE_VERSION="3.6.0"
ENV USER_HOME="/opt/app"

USER root

RUN  addgroup -g ${GROUP_ID} ${GROUP} && \
     adduser -u ${USER_ID} -D -g '' -h ${USER_HOME} -G ${GROUP} ${USER}

RUN apk add --update --no-cache curl && \
    curl -L -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64-slim && \
    chmod +x /usr/local/bin/gomplate

COPY --chown=${USER}:${USER} --from=builder /opt/app/cyclotron-site/_public ${USER_HOME}/cyclotron-site/_public
COPY --chown=${USER}:${USER} templates/nginx.conf /etc/nginx/conf.d/cyclotron-site.conf
COPY --chown=${USER}:${USER} templates/configService.js ${USER_HOME}/cyclotron-site/_public/js/conf/configService.tpl

COPY --chown=${USER}:${USER} docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 8087

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["nginx", "-g", "daemon off;"]