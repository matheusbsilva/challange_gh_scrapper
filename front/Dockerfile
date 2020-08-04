FROM node:14.7-alpine

ENV INSTALL_PATH /app/

WORKDIR $INSTALL_PATH

COPY package* $INSTALL_PATH

RUN npm install

COPY . $INSTALL_PATH

CMD npm run serve


