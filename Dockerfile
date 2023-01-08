# syntax=docker/dockerfile:1
FROM node:lts-alpine
WORKDIR /app
RUN apk add --no-cache redis git supervisor tini && corepack prepare yarn@stable --activate && git clone https://github.com/hitokoto-osc/hitokoto-api.git . && yarn workspaces focus --production && apk del --no-cache git
WORKDIR /
ENTRYPOINT ["/sbin/tini", "--"]
COPY supervisord.conf /etc/supervisord.conf
CMD /usr/bin/supervisord -n -c /etc/supervisord.conf
