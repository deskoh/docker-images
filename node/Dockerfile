ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi8/ubi-minimal
ARG BASE_TAG=latest
ARG NODE_VERSION=lts

FROM node:${NODE_VERSION} as base

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

ENV HOME=/home/node \
    USER=node

RUN microdnf --disableplugin=subscription-manager install --nodocs shadow-utils && \
    groupadd -g 1001 node && \
    adduser -r -u 1001 -m -s /sbin/nologin -g node node && \
    chown node:0 ${HOME} && \
    chmod g=u ${HOME} && \
    microdnf --disableplugin=subscription-manager update && \
    microdnf --disableplugin=subscription-manager clean all && \
    rm -rf /var/cache/yum

COPY --from=base /usr/local/bin /usr/local/bin
COPY --from=base /usr/local/include /usr/local/include
COPY --from=base /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=base /opt /opt
COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR ${HOME}
USER 1001

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node"]
