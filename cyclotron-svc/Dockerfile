FROM node:6-alpine

LABEL maintainer="Florian JUDITH <florian.judith.b@gmail.com>"

ENV SERVICENAME="cyclotron-svc" \
    USER="node" \
    DAEMON="node" \
    ROOT_DIR="/opt/app/cyclotron-svc" \
    SERVER="$ROOT_DIR/app.js" \
    LOG_ROOT="$ROOT_DIR/log" \
    LOG_FILE="$LOG_ROOT/app.log" \
    LOCK_ROOT="/var/lock/subsys" \
    LOCK_FILE="$LOCK_ROOT/$SERVICENAME"

RUN cd /tmp && \
    apk add --update --no-cache git jq python make && \
    git clone https://github.com/ExpediaInceCommercePlatform/cyclotron && \
    apk del git && \
    mkdir -p /opt/app && \
    mv cyclotron/cyclotron-svc /opt/app/ && \
    mkdir -p /opt/app/cyclotron-svc/log && \
    rm -rf /tmp/cyclotron

USER root

WORKDIR /opt/app/cyclotron-svc

RUN npm install -g \
    phantomjs-prebuilt \
    casperjs && \
    npm install

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chown node:node /docker-entrypoint.sh && \
    chmod +x /docker-entrypoint.sh && \
    chown -R node:node /opt/app/

USER node

EXPOSE 8087

ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["node", "app.js"]
