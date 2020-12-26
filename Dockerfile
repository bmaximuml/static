FROM nginx:1.19-alpine

ARG USER static

COPY --chown ${USER}:${USER} ./  /usr/share/nginx/html
