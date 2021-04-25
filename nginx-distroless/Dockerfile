ARG BASE_REGISTRY=gcr.io
ARG BASE_IMAGE=distroless/base-debian10
ARG BASE_TAG=latest

ARG NGINX_VERSION=1.19.10
FROM nginxinc/nginx-unprivileged:${NGINX_VERSION} as nginx

USER root

RUN cp -a --parents /etc/group /opt && \
    cp -a --parents /etc/passwd /opt && \
    cp -a --parents /etc/ca-certificates.conf /opt && \
    cp -a --parents /etc/ssl /opt && \
    cp -a --parents /etc/nginx /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libexpat* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libhistory* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libkeyutils* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libpcre.so.* /opt && \
    cp -a --parents /lib/x86_64-linux-gnu/libz.so.* /opt && \
    cp -a --parents /usr/lib/nginx /opt && \
    cp -a --parents /usr/lib/ssl /opt && \
    cp -a --parents /usr/sbin/nginx /opt && \
    cp -a --parents /usr/sbin/update-ca-certificates /opt && \
    cp -a --parents /usr/share/ca-certificates/ /opt && \
    cp -a --parents /usr/share/nginx/ /opt && \
    cp -a --parents /var/log/nginx/ /opt && \
    mkdir -p /opt/var/cache/nginx && \
    ls

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as base
COPY --from=nginx /opt /

USER 1001
ENTRYPOINT ["nginx", "-g", "daemon off;"]
