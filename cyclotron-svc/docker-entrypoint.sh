#!/bin/sh
set -e

MONGO_URL=${MONGO_URL:-"mongodb://mongodb/cyclotron"}
LISTEN_PORT=${LISTEN_PORT:-"8087"}
BASE_PATH=${BASE_PATH:-"/"}
WEB_SERVER=${WEB_SERVER:-"http://localhost:80"}
ENCRYPTION_KEY=${ENCRYPTION_KEY:-""}
LOAD_EXAMPLES_DASHBOARDS=${LOAD_EXAMPLES_DASHBOARDS:-"true"}

ANALYTICS_ENABLE=${ANALYTICS_ENABLE:-"False"}
ANALYTICS_ENGINE=${ANALYTICS_ENGINE:-"mongo"}

ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-"http://elasticsearch:9200"}
ELASTICSEARCH_INDEX_PREFIX=${ELASTICSEARCH_INDEX_PREFIX:-"cyclotron"}
ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY=${ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY:-"monthly"}
ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY=${ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY:-"monthly"}
ELASTICSEARCH_EVENTS_INDEX_STRATEGY=${ELASTICSEARCH_EVENTS_INDEX_STRATEGY:-"yearly"}

AUTH_ENABLE=${AUTH_ENABLE:-"false"}

LDAP_URL=${AUTH_LDAP_URL:-"ldap://ldap:389"}
LDAP_SEARCH_BASE=${AUTH_LDAP_SEARCH_BASE:-"ou=users, dc=example, dc=com"}
LDAP_SEARCH_FILTER=${AUTH_LDAP_SEARCH_FILTER:-"(cn={{username}})"}
LDAP_ADMIN_DN=${AUTH_LDAP_ADMIN_DN:-""}
LDAP_ADMIN_PASSWORD=${AUTH_LDAP_ADMIN_PASSWORD:-""}
LDAP_SEARCH_CATEGORIES=${LDAP_SEARCH_CATEGORIES:-"/* name: '', dn: '' */"}

AUTH_ADMINS=${AUTH_ADMINS:-""}

REQUEST_LIMIT=${REQUEST_LIMIT:-"5m"}

TRUSTED_CA=""

echo "Writing configuration file from environment variables"

cat << EOF > ${ROOT_DIR}/config/config.js
module.exports = {
    mongodb: "${MONGO_URL}",
    port: "${LISTEN_PORT}",
    basePath: "${BASE_PATH}",
    webServer: "${WEB_SERVER}",
    encryptionKey: "${ENCRYPTION_KEY}",
    loadExamplesDashboards: "${LOAD_EXAMPLES_DASHBOARDS}",
    analytics: {
        enable: "${ANALYTICS_ENABLE}",
        analyticsEngine: "${ANALYTICS_ENGINE}",
        elasticsearch: {
            host: [
                "${ELASTICSEARCH_HOST}"
            ],

            indexPrefix: "${ELASTICSEARCH_INDEX_PREFIX}",
            pageviewsIndexStrategy: "${ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY}",
            datasourcesIndexStrategy: "${ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY}",
            eventsIndexStrategy: "${ELASTICSEARCH_EVENTS_INDEX_STRATEGY}"
        }
    },
    enableAuth: "${AUTH_ENABLE}",
    ldap: {
        url: "${LDAP_URL}",
        searchBase: "${LDAP_SEARCH_BASE}",
        searchFilter: "${LDAP_SEARCH_FILTER}",
        adminDn: "${LDAP_ADMIN_DN}",
        adminPassword: "${LDAP_ADMIN_PASSWORD}",
        searchCategories: [
            ${LDAP_SEARCH_CATEGORIES}
        ]
    },
    admins: "${AUTH_ADMINS}",
    requestLimit: "${REQUEST_LIMIT}",
    trustedCa: [
        ${TRUSTED_CA}
    ]
};
EOF

if [ "${1#-}" != "${1}" ] || [ -z "$(command -v "${1}")" ]; then
  set -- /usr/local/bin/node "$@"
fi

exec "$@"