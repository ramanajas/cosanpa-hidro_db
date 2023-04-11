FROM node:12-alpine
# LABEL maintainer 'COASNPA/PRODIGA'

COPY ./server /var/www/html

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm install -g nodemon --cache /tmp/empty-cache \
   && npm run \
   && npm install 

EXPOSE 8080

CMD ["nodemon", "-L", "server.js"]