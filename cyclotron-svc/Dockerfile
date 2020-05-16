FROM node:lts-alpine

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

ARG USER="cyclotron"
ARG USER_ID="1009"
ARG GROUP="cyclotron"
ARG GROUP_ID="1009"
ARG GOMPLATE_VERSION="3.6.0"
ENV USER_HOME="/home/${USER}"

USER root

RUN  addgroup -g ${GROUP_ID} ${GROUP} && \
     adduser -u ${USER_ID} -D -g '' -h ${USER_HOME} -G ${GROUP} ${USER}

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

COPY --chown=${USER}:${USER} docker-entrypoint.sh /docker-entrypoint.sh
COPY --chown=${USER}:${USER} templates/config.js ./config/config.tpl

RUN chmod +x /docker-entrypoint.sh && \
    chown -R ${USER}:${USER} ${USER_HOME}/cyclotron-svc && \
    npm install

USER ${USER}

EXPOSE 8077

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["node", "app.js"]
