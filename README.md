# [HIDRO-db](https://github.com/rafaeelneto/hidro_db)

Hidro-db is a platform that manages mainly water wells, but also other assets that compose water distribution systems, of county-wide sanitization companies. This application was designed as a solution to day-to-day problems of data gathering, organization, and sharing inside a water distribution company.

The platform is composed of a PostgreSQL database for data persistence, a Hasura server to provide fully customizable and automated GraphQl endpoint, a Node.js server to serve some custom logic like authentication and authorization, or any other specific needs, and a React front-end app to provide an accessible web interface that allows users, employees, and decision-makers to easily visualize data.

![Hidro-db screen examples](/application/statics/src/assets/images/hidro-db_exemplos-01.png)

### Maintainer 
rafaelneto.g@gmail.com

#

## Database

It's a instance of a PostgreSQL v9+ with a PostGIS extension installed. I will provide in the future a organized SQL start file to compose the database in a new enviroment.

### Requiments

This are some exterions required for the database to run

  - postgis:   `CREATE EXTENSION postgis`
  - uuid-ossp: `CREATE EXTENSION IF NOT EXISTS "uuid-ossp";`

After plugins installment, the tables, relations and data can be inputed on the database.

You can add the database a running server on your localmachine, a specified cloud SQL provider or a Docker container.

## Docker

Before compose the application with `docker compose up -d`, you must run `npm install` on server folder and then build the Dockerfile image inside that folder.

Inside the docker-compose file it must be modified some enviroment variables to

    `HASURA_GRAPHQL_DATABASE_URL: postgres://postgres:desenv@192.168.100.105:5432/hidro_db_dev`
    Ex:
    postgresql://[user[:password]@][IP_DO_SERVIDOR_DE_BANCO][:port][/dbname][?param1=value1&...]



**The JWT key must be equal on Node.ks and Hasura env variables**

**Make sure your docker is allowed to mount the directory C:/.../hidro-db/...**

## Client-side interface

The web interface that provides a accesible way to users to visualize and edit the data was build in React. Anothers tools used were D3.js and Leaflet

To run the client application you must type:

`npm install`
If you're using Node.JS 16+, you must run `npm install --legacy-peer-deps`

`npm start`

This is a ongoing project and updates will be placed here


## Transfer code to a remote server manualy 

    rsync -azve 'ssh -p PORTA' --exclude=.git ORIGEM DESTINHO

	  rsync -azve 'ssh' --exclude=logs --exclude=.git ../cosanpa-hidro_db lab:~

## Build Manualy
    

### PostgreSQL

      mkdir -p $PWD/database/container/logs \
    ; sudo chown -R 999:999 $PWD/database/container \
    ; docker container rm db -f \
    ; docker volume rm postgresql_data \
    ; docker image rm cosanpa/postgis:11-3.3 \
    ; docker image build -t cosanpa/postgis:11-3.3 $PWD/database \
    ; docker volume create postgresql_data \
    ; docker container run \
                --detach \
                --name db \
                --publish 5432:5432 \
                --restart always \
                --volume /etc/localtime:/etc/localtime:ro \
                --volume postgresql_data:/var/lib/postgresql/data \
                --volume $PWD/database/container:/backup \
                --env POSTGRES_USER=gis \
                --env POSTGRES_PASSWORD=desenv \
                cosanpa/postgis:11-3.3 

    docker container exec db ./restore.sh

#

### Hasura without migrations

      export DATABASE_URL='postgres://gis:desenv@192.168.31.240:5432/hidro_db_dev' \
    ; docker container rm graph -f \
    ; docker container run \
                --detach \
                --name graph \
                --publish 3001:3000 \
                --publish 9893:9693 \
                --publish 9895:9695 \
                --restart always \
                --volume /etc/localtime:/etc/localtime:ro \
                --env HASURA_GRAPHQL_DATABASE_URL=$DATABASE_URL \
                --env HASURA_GRAPHQL_ENABLE_CONSOLE=true \
                --env HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log" \
                --env HASURA_GRAPHQL_SERVER_PORT=3000 \
                --env HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey \
                --env HASURA_GRAPHQL_JWT_SECRET='{"type":"HS256", "key": "3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R"}' \
                hasura/graphql-engine:v1.3.3

#
                
                
    Ex:
    postgresql://[user[:password]@][IP_DO_SERVIDOR_DE_BANCO][:port][/dbname][?param1=value1&...]

  


http://localhost:3001/

    myadminsecretkey

Query

    { pocos { id nome } }

#

### NodeJ

      docker container rm nodej -f \
    ; docker image rm cosanpa/nodej:14 \
    ; docker image build -t cosanpa/nodej:14 $PWD/application \
    ; docker container run \
                --detach \
                --name server \
                --publish 8080:8081 \
                --restart always \
                --volume /etc/localtime:/etc/localtime:ro \
                --env PORT=8081 \
                --env NODE_ENV=production \
                --env JWT_SECRET='3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R' \
                --env HOST_URL='http://localhost' \
                cosanpa/nodej:14

#

### Nginx
    
      docker container rm nginx -f \
    ; docker container run \
                --detach \
                --restart always \
                --publish 80:80 \
                --publish 443:443 \
                --name nginx \
                --volume /etc/localtime:/etc/localtime:ro \
                --volume ./nginx/conf:/etc/nginx/conf.d \
                --volume ./nginx/logs:/var/log/nginx \
                nginx:latest


#

 ### Hasura with migrations

      export DATABASE_URL='postgres://gis:desenv@192.168.31.240:5432/hidro_db_dev' \
    ; docker container rm graph -f \
    ; docker image rm cosanpa/graph:1.3.3 \
    ; docker image build -t cosanpa/graph:1.3.3 $PWD/hasura \
    ; docker container run \
                --detach \
                --name graph \
                --publish 3001:3000 \
                --publish 9893:9693 \
                --publish 9895:9695 \
                --restart always \
                --env HASURA_GRAPHQL_DATABASE_URL=$DATABASE_URL \
                --env HASURA_GRAPHQL_ENABLE_CONSOLE=true \
                --env HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log" \
                --env HASURA_GRAPHQL_SERVER_PORT=3000 \
                --env HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey \
                --env HASURA_GRAPHQL_JWT_SECRET='{"type":"HS256", "key": "3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R"}' \
                --env HASURA_GRAPHQL_MIGRATIONS_DIR=/hasura/migrations \
                cosanpa/graph:1.3.3



### Compile Manualy

rm -rf node_modules/ build/ package-lock.json && npm install --legacy-peer-deps && npm update && npm -g outdated --depth=3
