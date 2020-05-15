## Introduction

[Cyclotron](https://cyclotron.io) is a browser-based platform built by [Expedia](https://expedia.com) for constructing dashboards. Build on and requiring [MongoDB](https://mongdb.com) and [Node.js](https://nodejs.org), It provides standard boilerplate and plumbing, allowing non-programmers to easily create and edit dashboards using customizable components. It has a built-in dashboard editor, and hosts the dashboards directly.

In this repository

* Site (webui) and Svc (api) docker images that are always up-to-date with cyclotron releases
* docker-compose to run cyclotron application stack with mongodb
* kubernetes manifests to run cyclotron.

## Description

The Dockefile builds from `node:14` then `nginx:stable-alpine` for the **cyclotron-site** and `node:6-apline` for the **cyclotron-svc**.

## Features

* Run components as non-root
* Support for LDAP authentication

## Quick start

Run the entire stack using docker-compose.

```bash
git clone https://github.com/fjudith/docker-cyclotron
cd deploy/docker-compose
docker-compose up -d
```

## Environment variables

The following tables describe the environment variables supported by the **cryclotron-site** and **cyclotron-svc** containers.


### API service (cyclotron-svc)

Variable | Description | Default
-------- | ----------- | -------
MONGO_URI | Connection string to access the MongoDB database | `mongo://mongodb:27017/cyclotron`
LISTEN_PORT | Port to run the Cyclotron Service on | `8087`
BASE_PATH | Base path this server is hosted at; used by Swagger docs | `/`
WEB_SERVER | URL for website using this service; Used for exporting Dashboards as PDFs via CasperJS | `http://cyclotron-site`
ENCRYPTION_KEY | Key for encrypting/decrypting strings on the /crypto endpoint | `""`
LOAD_EXAMPLES_DASHBOARDS | If enabled, loads example Dashboards from /examples folder into the database | `True`
ANALYTICS_ENABLE | Enable or disable analytic data collection | `False`
ANALYTICS_ENGINE | Possible values: `mongo`, `elasticsearch` | `mongo`
ELASTICSEARCH_HOST | Elasticsearch server hostname and port (use comma `","` for multiple server) | `elasticsearch:9200`
ELASTICSEARCH_INDEX_PREFIX | Prefix of Cyclotron indices | `cyclotron`
ELASTICSEARCH_PAGE_VIEWS_INDEX_STRATEGY | Configure how frequently to rotate to new page views indicies | `monthly`
ELASTICSEARCH_DATASOURCES_INDEX_STRATEGY | Configure how frequently to rotate to new datasources indicies | `monthly`
ELASTICSEARCH_EVENTS_INDEX_STRATEGY | Configure how frequently to rotate to new event indicies | `yearly`
