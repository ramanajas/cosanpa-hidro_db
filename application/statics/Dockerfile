FROM node:16.20.0-buster
#node:14.21.3-alpine3.17
#node:12-alpine

#RUN mkdir -p /usr/src/app
WORKDIR /usr/src/html

COPY . .

#RUN npm install
# RUN   npm cache verify \
#    && npm install \
#    && npm run build

RUN   npm cache verify 
RUN   npm install --legacy-peer-deps
RUN   npm run build

#COPY . .

EXPOSE 8080

CMD ['npm', 'build']