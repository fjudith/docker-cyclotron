#!/bin/sh
set -e

export REST_SERVICE_URL="http://cyclotron-svc:8077"
export EXTERNAL_SERVICE_URL="http://localhost:8077"
export GRAPHITE_URL="http://sampleGraphiteHost:80"
export SPLUNK_HOST="splunk"

echo "Writing configuration file from environment variables"

if ! [ -f ${USER_HOME}/cyclotron-site/_public/js/conf/configService.js ]; then

    gomplate -f ${USER_HOME}/cyclotron-site/_public/js/conf/configService.tpl \
             -o ${USER_HOME}/cyclotron-site/_public/js/conf/configService.js

fi

exec "$@"