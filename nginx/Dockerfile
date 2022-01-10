ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi8/ubi
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}
ARG NGINX_VERSION=1.21.5

USER root

RUN dnf --disableplugin=subscription-manager upgrade -y && \
    curl -Lso /tmp/nginx-${NGINX_VERSION}.rpm https://nginx.org/packages/mainline/rhel/8/x86_64/RPMS/nginx-${NGINX_VERSION}-1.el8.ngx.x86_64.rpm && \
    curl -Lso /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key && \
    rpm --import /tmp/nginx_signing.key && \
    dnf install -y /tmp/nginx-${NGINX_VERSION}.rpm && \
    rm -f /tmp/nginx-${NGINX_VERSION}.rpm /tmp/nginx_signing.key && \
    # pipe logs to stdout / stderr
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    # remove user directive from nginx.conf
    sed -i '/user  nginx;/d' /etc/nginx/nginx.conf && \
    # change port to 8080
    sed -i 's/80;/8080;/g' /etc/nginx/conf.d/default.conf && \
    # fix nginx user permissions
    chown -R nginx:nginx /usr/share/nginx && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid && \
    dnf --disableplugin=subscription-manager clean all && \
    rm -rf /var/cache/dnf

USER nginx

EXPOSE 8080 8443

HEALTHCHECK --interval=10s --timeout=5s --start-period=1m --retries=5 CMD curl -I -f --max-time 5 http://localhost:8080 || curl -fsk https://localhost:8443 || exit 1

CMD ["nginx", "-g", "daemon off;"]
