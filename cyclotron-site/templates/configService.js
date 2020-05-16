cyclotronServices.factory('configService', ['commonConfigService', function(commonConfigService) {
  var cyclotronEnvironments, exports, merged, proxyOptions;
  cyclotronEnvironments = [
    {
      name: 'Dev',
      serviceUrl: 'http://cyclotron/api',
      requiresAuth: true,
      canPush: true
    }, {
      name: 'Localhost',
      serviceUrl: 'http://localhost:8077',
      requiresAuth: false,
      canPush: false
    }
  ];
  proxyOptions = _.reduce(cyclotronEnvironments, function(options, environment) {
    options[environment.name] = {
      value: environment.serviceUrl
    };
    return options;
  }, {});
  exports = {
    restServiceUrl: '{{ .Env.EXTERNAL_SERVICE_URL }}',
    authentication: {
      enable: false,
      loginMessage: 'Please login using your LDAP username and password.',
      cacheEncryptedPassword: false
    },
    analytics: {
      enable: false
    },
    logging: {
      enableDebug: false
    },
    newUser: {
      enableMessage: true
    },
    cyclotronEnvironments: cyclotronEnvironments,
    dashboard: {
      properties: {
        dataSources: {
          options: {
            cyclotronData: {
              properties: {
                url: {
                  options: proxyOptions
                }
              }
            },
            graphite: {
              properties: {
                url: {
                  "default": '{{ .Env.GRAPHITE_URL }}'
                },
                proxy: {
                  options: proxyOptions
                }
              }
            },
            json: {
              properties: {
                proxy: {
                  options: proxyOptions
                }
              }
            },
            prometheus: {
              properties: {
                proxy: {
                  options: proxyOptions
                }
              }
            },
            splunk: {
              properties: {
                host: {
                  "default": '{{ .Env.SPLUNK_HOST }}'
                },
                proxy: {
                  options: proxyOptions
                }
              }
            }
          }
        }
      }
    },
    dashboardSidebar: {
      footer: {
        logos: [
          {
            title: 'Cyclotron',
            src: '/img/favicon32.png',
            href: '/'
          }
        ]
      }
    }
  };
  merged = _.merge(commonConfigService, exports, _["default"]);
  merged.help[0].messages = [
    {
      type: 'info',
      html: 'Welcome to Cyclotron!',
      icon: 'fa-info-circle'
    }
  ];
  return merged;
}]);