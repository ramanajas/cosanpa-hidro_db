FROM node:14.21.3-alpine3.17
#node:12-alpine as builder
# LABEL maintainer='COSANPA/PRODIGA'
# LABEL maintainer=ramanajas@prodigasistemas.com.br
# LABEL maintainer=rafaelneto.g@gmail.com

COPY ./statics /var/www/html

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm install --legacy-peer-deps \
   && npm run build

FROM node:14.21.3-alpine3.17
#node:12-alpine

COPY --from=builder /var/www/html/build/ /var/www/html/public/
COPY ./server /var/www/html

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm install -g nodemon --cache /tmp/empty-cache \
   && npm run \
   && npm install 

EXPOSE 8080

CMD ["nodemon", "-L", "server.js"]