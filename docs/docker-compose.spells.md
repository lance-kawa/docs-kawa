# Spells 📚

Here is a list of common container for a docker-compose file : 

##  Postgres
```yaml
postgres:
  image: postgres:${POSTGRES_VERSION:-latest}
  restart: always
  container_name: postgres
  environment:
    - POSTGRES_USER=${POSTGRES_USER}
    - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
    - POSTGRES_DB=${POSTGRES_DB}
  healthcheck:
    interval: 10s
    retries: 10
    test: "pg_isready -U \"$$POSTGRES_USER\" -d \"$$POSTGRES_DB\""
    timeout: 2s
  volumes:
    - ${APPDATA}/postgres:/var/lib/postgresql/data
```
A robust and reliable PostgreSQL database service, perfect for data storage and management.

##  MongoDB
```yaml
mongodb:
  image: docker.io/bitnami/mongodb:${MONGODB_VERSION:-latest}
  container_name: mongodb
  restart: always
  volumes:
    - ${APPDATA}/mongo:/bitnami/mongodb
  environment:
    MONGODB_REPLICA_SET_MODE: primary
    MONGODB_REPLICA_SET_NAME: rs0
    MONGODB_PORT_NUMBER: 27017
    MONGODB_INITIAL_PRIMARY_HOST: mongodb
    MONGODB_INITIAL_PRIMARY_PORT_NUMBER: 27017
    MONGODB_ADVERTISED_HOSTNAME: mongodb
    MONGODB_ENABLE_JOURNAL: true
    ALLOW_EMPTY_PASSWORD: yes

```
A MongoDB service setup, great for applications requiring a NoSQL database with flexibility and scalability.

##  Nginx
```yaml
nginx:
  image: nginx:${NGINX_VERSION:-latest}
  container_name: nginx
  ports:
    - 80:80
    - 443:443
  volumes:
    - ${APPDATA}/nginx/nginx.conf:/etc/nginx/conf.d/default.conf
    - /etc/letsencrypt:/etc/letsencrypt
```
The Nginx service acts as a web server, handling HTTP requests and serving your web content securely.

##  File Manager
```yaml
file_manager:
  image: filebrowser/filebrowser:${FILEBROWSER_VERSION:-latest}
  container_name: file_manager
  ports:
    - 8080:80
  volumes:
    - ${APPDATA}/filebrowser/srv:/srv
    - ${APPDATA}/filebrowser/db/filebrowser.db:/database/filebrowser.db
    - ${APPDATA}/filebrowser/config/settings.json:/config/settings.json

```
A simple and convenient web-based file manager for managing and accessing your files remotely.

## Vaultwarden
```yaml
vault:
  image: vaultwarden/server:${VAULT_VERSION:-latest}
  container_name: vaultwarden
  volumes:
    - ${APPDATA}/vault/:/data/
  ports:
    - 8081:80
  restart: unless-stopped


```
A secure service for managing passwords and other sensitive data, ensuring your credentials are safe and accessible.


##  Portainer
```yaml
portainer:
  image: portainer/portainer-ce:${PORTAINER_VERSION:-latest}
  container_name: portainer
  ports:
    - 8082:9000
  volumes:
      - ${APPDATA}/portainer/data:/data
      - /var/run/docker.sock:/var/run/docker.sock
  command:
    --http-enabled
  restart: unless-stopped

```
Portainer simplifies Docker container management, providing a user-friendly interface for handling your Docker environments.

## RocketChat
```yaml
rocketchat:
  image: registry.rocket.chat/rocketchat/rocket.chat:${ROCKETCHAT_VERSION:-latest}
  restart: always
  container_name: rocketchat
  environment:
    MONGO_URL: ${MONGO_URL}/rocketchat?replicaSet=rs0
    MONGO_OPLOG_URL: ${MONGO_URL}/rocketchat?replicaSet=rs0
    ROOT_URL: https://chat.${DOMAIN}
    PORT: 3000
    DEPLOY_METHOD: docker
  depends_on:
    - mongodb
  expose:
    - 3000
  ports:
    - 127.0.0.1:8083:3000
```
RocketChat is your own private chat platform, a secure place to communicate and collaborate with your team.


## n8n
```yaml
n8n:
  image: docker.n8n.io/n8nio/n8n:${N8N_VERSION:-latest}
  container_name: n8n
  restart: always
  ports:
    - 127.0.0.1:5678:5678
  environment:
    - N8N_HOST=n8n.${DOMAIN}
    - N8N_PORT=5678
    - N8N_PROTOCOL=https
    - NODE_ENV=production
    - WEBHOOK_URL=https://n8n.${DOMAIN}/
    - GENERIC_TIMEZONE=Europe/London
  volumes:
    - n8n_data:/home/node/.n8n
    - ${APPDATA}/local_files:/files

```
n8n (nodemation) is a workflow automation tool that connects various apps, services, and APIs for streamlined automation.

## Gitea
```yaml
gitea:
  image: gitea/gitea:${GITEA_VERSION:-latest}
  container_name: gitea
  environment:
    - USER_UID=1000
    - USER_GID=1000
  restart: always
  volumes:
    - ${APPDATA}/gitea:/data
    - /etc/timezone:/etc/timezone:ro
    - /etc/localtime:/etc/localtime:ro
  ports:
    - 8084:3000
    - 222:22
```
Gitea is a lightweight and powerful Git service, a self-hosted alternative for managing your repositories.

## NoCoDB
```yaml
nocodb:
  image: nocodb/nocodb:${NOCODB_VERSION:-latest}
  container_name: nocodb
  restart: always
  depends_on:
    postgres:
      condition: service_healthy
  environment:
    NC_DB: ${POSTGRES_URL}&d=noco_app
  ports:
    - 8085:8080
  volumes:
    - ${APPDATA}/noco/data:/usr/app/data
```
NoCoDB turns your PostgreSQL database into a smart spreadsheet, providing a flexible and user-friendly interface for database management.


## Duplicati
```yaml
duplicati:
  image: lscr.io/linuxserver/duplicati:${DUPLICATI_VERSION:-latest}
  container_name: duplicati
  environment:
    - PUID=0
    - PGID=0
    - TZ=Etc/UTC
  volumes:
    - ${APPDATA}/duplicati/config:/config
    - ${APPDATA}:/backups
    - ${APPDATA}:/source
  ports:
    - 8087:8200
  restart: unless-stopped

```
Duplicati is a free backup software, ensuring your data's safety with encrypted, offsite storage options.