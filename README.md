# HIDRO-db

Hidro-db is a platform that manages mainly water wells, but also other assets that compose water distribution systems, of county-wide sanitization companies. This application was designed as a solution to day-to-day problems of data gathering, organization, and sharing inside a water distribution company.

The platform is composed of a PostgreSQL database for data persistence, a Hasura server to provide fully customizable and automated GraphQl endpoint, a Node.js server to serve some custom logic like authentication and authorization, or any other specific needs, and a React front-end app to provide an accessible web interface that allows users, employees, and decision-makers to easily visualize data.

![Hidro-db screen examples](/client/src/assets/images/hidro-db_exemplos-01.png)

## Database

It's a instance of a PostgreSQL v9+ with a PostGIS extension installed. I will provide in the future a organized SQL start file to compose the database in a new enviroment.

### Requiments

This are some exterions required for the database to run

- postgis: `CREATE EXTENSION postgis`
- postgresql-9.6-postgis-3
- postgresql-9.6-postgis-3-dbgsym
- postgresql-9.6-postgis-3-scripts
- uuid-ossp: `CREATE EXTENSION IF NOT EXISTS "uuid-ossp";`

After plugins installment, the tables, relations and data can be inputed on the database.

You can add the database a running server on your localmachine, a specified cloud SQL provider or a Docker container.

## Docker

Before compose the application with `docker-compose up`, you must run `npm install` on server folder and then build the Dockerfile image inside that folder.

Inside the docker-compose file it must be modified some enviroment variables to

`HASURA_GRAPHQL_DATABASE_URL: postgres://postgres:postgres@docker.for.win.localhost:5432/hidro_db_dev`

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

	rsync -azve 'ssh' --exclude=.git ad-hoc lab:~

## Build Manualy
    

### PostgreSQL zerado

      docker container rm db -f \
    ; docker volume rm postgresql_data \
    ; docker image rm cosanpa/postgis:11-3.3 \
    ; docker image build -t cosanpa/postgis:11-3.3 ./postgis \
    ; docker volume create postgresql_data \
    ; docker container run \
                --detach \
                --name db \
                --publish 5432:5432 \
                --restart always \
                --volume postgresql_data:/var/lib/postgresql/data \
                --volume $PWD/database:/backup \
                --env POSTGRES_USER=gis \
                --env POSTGRES_PASSWORD=desenv \
                cosanpa/postgis:11-3.3 

### Hasura
      docker container rm graph -f \
    ; docker image rm cosanpa/graph:1.3.3 \
    ; docker image build -t cosanpa/graph:1.3.3 ./hasura \
    ; docker container run \
                --detach \
                --name graph \
                --publish 3001:3000 \
                --publish 9893:9693 \
                --publish 9895:9695 \
                --restart always \
                --env HASURA_GRAPHQL_DATABASE_URL=postgres://gis:desenv@192.168.31.100:5432/hidro_db_dev \
                --env HASURA_GRAPHQL_ENABLE_CONSOLE=true \
                --env HASURA_GRAPHQL_ENABLED_LOG_TYPES="startup, http-log" \
                --env HASURA_GRAPHQL_SERVER_PORT=3000 \
                --env HASURA_GRAPHQL_ADMIN_SECRET=myadminsecretkey \
                --env HASURA_GRAPHQL_JWT_SECRET='{"type":"HS256", "key": "3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R"}' \
                --env HASURA_GRAPHQL_MIGRATIONS_DIR=/hasura/migrations \
                cosanpa/graph:1.3.3
                
      # postgresql://[user[:password]@][IP_DO_SERVIDOR_DE_BANCO][:port][/dbname][?param1=value1&...]

### NodeJ

      docker container rm nodej -f \
    ; docker image rm cosanpa/nodej:12 \
    ; docker image build -t cosanpa/nodej:12 ./server \
    ; docker container run \
                --detach \
                --name nodej \
                --publish 8080:8081 \
                --restart always \
                --volume /etc/localtime:/etc/localtime:ro \
                --volume ./server:/usr/src/app \
                --workdir /usr/src/app \
                --env PORT=8081 \
                --env NODE_ENV=production \
                --env JWT_SECRET='3EK6FD+o0+c7tzBNVfjpMkNDi2yARAAKzQlk8O2IKoxQu4nF7EdAh8s3TwpHwrdWT6R' \
                --env HOST_URL='http://localhost' \
                cosanpa/nodej:12 'nodemon -L server.js'
                    
### nginx
    
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

