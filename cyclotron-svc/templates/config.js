module.exports = {
    mongodb: "{{ .Env.MONGO_URL  }}",
    port: {{ .Env.LISTEN_PORT  }},
    basePath: "{{ .Env.BASE_PATH  }}",
    webServer: "{{ .Env.WEB_SERVER  }}",
    encryptionKey: "{{ .Env.ENCRYPTION_KEY  }}",
    loadExampleDashboards: {{ .Env.LOAD_EXAMPLE_DASHBOARDS  }},
    analytics: {
        enable: {{ .Env.ANALYTICS_ENABLE  }},
        analyticsEngine: "{{ .Env.ANALYTICS_ENGINE  }}",
        elasticsearch: {
            host: [
                "{{ .Env.ELASTICSEARCH_HOST  }}"
            ],

            indexPrefix: "{{ .Env.ELASTICSEARCH_INDEX_PREFIX  }}",
            pageviewsIndexStrategy: "{{ .Env.ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY  }}",
            datasourcesIndexStrategy: "{{ .Env.ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY  }}",
            eventsIndexStrategy: "{{ .Env.ELASTICSEARCH_EVENTS_INDEX_STRATEGY  }}"
        }
    },
    enableAuth: {{ .Env.AUTH_ENABLE  }},
    ldap: {
        url: "{{ .Env.LDAP_URL  }}",
        searchBase: "{{ .Env.LDAP_SEARCH_BASE  }}",
        searchFilter: "{{ .Env.LDAP_SEARCH_FILTER  }}",
        adminDn: "{{ .Env.LDAP_ADMIN_DN  }}",
        adminPassword: "{{ .Env.LDAP_ADMIN_PASSWORD  }}",
        searchCategories: [
            {{ .Env.LDAP_SEARCH_CATEGORIES  }}
        ]
    },
    admins: "{{ .Env.AUTH_ADMINS  }}",
    requestLimit: "{{ .Env.REQUEST_LIMIT  }}",
    trustedCa: [
        {{ .Env.TRUSTED_CA  }}
    ]
};