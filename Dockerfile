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
        ${USER}

COPY --chown=${USER}:${USER} src/  ${WORKDIR}

HEALTHCHECK --interval=10s CMD curl --fail localhost:80 || exit 1
