FROM nginx:1.19-alpine

ARG USER=static
ARG WORKDIR=/usr/share/nginx/html
ARG SHELL=/bin/sh

RUN set -aeux; \
    apk add --update curl; \
    adduser \
        --home ${WORKDIR} \
        --shell ${SHELL} \
        --disabled-password \
        ${USER} ; \
    rm ${WORKDIR}/*

COPY --chown=${USER}:${USER} src/  ${WORKDIR}

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

HEALTHCHECK --interval=10s CMD curl --fail localhost:80/status || exit 1
