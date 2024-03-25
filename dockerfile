FROM node:alpine as builder

COPY ./src /app/src/
COPY ./package.json /app/package.json
COPY ./package-lock.json /app/package-lock.json
COPY ./tsconfig.json /app/tsconfig.json

WORKDIR /app

RUN npm ci
RUN npm run build

FROM node:alpine

RUN apk update && apk add --no-cache git && apk add shadow --no-cache

RUN groupadd -r docker-group && useradd -r -g docker-group docker-user
RUN mkdir /app && chown docker-user:docker-group /app
USER docker-user

WORKDIR /app
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD ["node", "./dist/server.js"]



