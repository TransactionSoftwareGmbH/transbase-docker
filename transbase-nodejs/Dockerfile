FROM node:16

LABEL maintainer=Loibl<loibl@transaction.de>

WORKDIR /app

RUN npm install @transaction/transbase-nodejs express

ENTRYPOINT [ "node", "src/main" ]

