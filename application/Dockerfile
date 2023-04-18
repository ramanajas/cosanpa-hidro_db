FROM node:18.16.0-alpine3.17 as builder
# LABEL maintainer='COSANPA/PRODIGA'
# LABEL maintainer=ramanajas@prodigasistemas.com.br
# LABEL maintainer=rafaelneto.g@gmail.com

ENV NODE_OPTIONS="--openssl-legacy-provider"

COPY ./statics /var/www/html

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm uninstall react-scripts --legacy-peer-deps \
   && npm install react-scripts@4.0.3 --legacy-peer-deps \
   && npm install readline --legacy-peer-deps \
   && npm run build

FROM node:18.16.0-alpine3.17

COPY ./server /var/www/html
COPY --from=builder /var/www/html/build/* /var/www/html/public/

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm install -g nodemon --cache /tmp/empty-cache \
   && npm run \
   && npm install 

EXPOSE 8080

CMD ["nodemon", "-L", "server.js"]