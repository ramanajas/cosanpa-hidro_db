FROM node:18.16.0-alpine3.17
# LABEL maintainer='COSANPA/PRODIGA'
# LABEL maintainer=ramanajas@prodigasistemas.com.br
# LABEL maintainer=rafaelneto.g@gmail.com
ENV NODE_OPTIONS="--openssl-legacy-provider"

COPY . /var/www/html

WORKDIR /var/www/html

RUN   npm cache verify \
   && npm uninstall react-scripts --legacy-peer-deps \
   && npm install react-scripts@4.0.3 --legacy-peer-deps \
   && npm install readline --legacy-peer-deps \
   && npm run build

EXPOSE 8080

CMD ['npm', 'build']