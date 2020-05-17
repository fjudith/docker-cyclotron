FROM node:lts-alpine

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

ARG GOMPLATE_VERSION="3.6.0"
ENV USER_HOME="/home/cyclotron"

USER root

RUN  addgroup -g 1009 cyclotron && \
     adduser -u 1009 -D -g '' -h ${USER_HOME} -G cyclotron cyclotron

RUN cd /tmp && \
    apk add --update --no-cache curl git python make && \
    git clone https://github.com/ExpediaInceCommercePlatform/cyclotron && \
    apk del git && \
    mv cyclotron/cyclotron-svc ${USER_HOME} && \
    mkdir -p ${USER_HOME}/cyclotron-svc/log && \
    rm -rf /tmp/cyclotron && \
    curl -L -o /usr/local/bin/gomplate https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64-slim && \
    chmod +x /usr/local/bin/gomplate

WORKDIR ${USER_HOME}/cyclotron-svc

COPY --chown=cyclotron:cyclotron docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=cyclotron:cyclotron templates/config.js ./config/config.tpl

RUN chmod +x /docker-entrypoint.sh && \
    chown -R cyclotron:cyclotron ${USER_HOME}/cyclotron-svc && \
    npm install

USER cyclotron

EXPOSE 8077

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["node", "app.js"]
