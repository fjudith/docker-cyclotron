#!/bin/sh
set -e

export MONGO_URL=${MONGO_URL:-"mongodb://mongodb:27017/cyclotron"}
export LISTEN_PORT=${LISTEN_PORT:-"8077"}
export BASE_PATH=${BASE_PATH:-"/"}
export WEB_SERVER=${WEB_SERVER:-"http://localhost:8087"}
export ENCRYPTION_KEY=${ENCRYPTION_KEY:-""}
export LOAD_EXAMPLE_DASHBOARDS=${LOAD_EXAMPLE_DASHBOARDS:-"true"}

export ANALYTICS_ENABLE=${ANALYTICS_ENABLE:-"false"}
export ANALYTICS_ENGINE=${ANALYTICS_ENGINE:-"mongo"}

export ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-"elasticsearch:9200"}
export ELASTICSEARCH_INDEX_PREFIX=${ELASTICSEARCH_INDEX_PREFIX:-"cyclotron"}
export ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY=${ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY:-"monthly"}
export ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY=${ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY:-"monthly"}
export ELASTICSEARCH_EVENTS_INDEX_STRATEGY=${ELASTICSEARCH_EVENTS_INDEX_STRATEGY:-"yearly"}

export AUTH_ENABLE=${AUTH_ENABLE:-"false"}

export LDAP_URL=${AUTH_LDAP_URL:-"ldap://ldap.example.com:389"}
export LDAP_SEARCH_BASE=${LDAP_SEARCH_BASE:-"ou=users, dc=example, dc=com"}
export LDAP_SEARCH_FILTER=${LDAP_SEARCH_FILTER:-"(cn={{username}})"}
export LDAP_ADMIN_DN=${LDAP_ADMIN_DN:-"cn=cyclotron, ou=apps, dc=example, dc=com"}
export LDAP_ADMIN_PASSWORD=${LDAP_ADMIN_PASSWORD:-""}
export LDAP_SEARCH_CATEGORIES=${LDAP_SEARCH_CATEGORIES:-"/* name: '', dn: '' */"}

export AUTH_ADMINS=${AUTH_ADMINS:-""}

export REQUEST_LIMIT=${REQUEST_LIMIT:-"5mb"}

export TRUSTED_CA=""

echo "Writing configuration file from environment variables"

if ! [ -f ${USER_HOME}/cyclotron-svc/config/config.js ]; then

    gomplate -f ${USER_HOME}/cyclotron-svc/config/config.tpl \
             -o ${USER_HOME}/cyclotron-svc/config/config.js

fi

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- node "$@"
fi

exec "$@"