FROM node:alpine

RUN apk update && apk upgrade

RUN mkdir -p /docker-web-terminal-frontend
WORKDIR /docker-web-terminal-frontend
COPY . /docker-web-terminal-frontend

ENTRYPOINT [ "ash", "-c", "/docker-web-terminal-frontend/scripts/run.sh" ]
