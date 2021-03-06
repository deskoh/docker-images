ARG BASE_REGISTRY=registry.access.redhat.com
ARG BASE_IMAGE=ubi8/ubi-minimal
ARG BASE_TAG=latest

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG} as builder

# Latest version: curl -L -s https://dl.k8s.io/release/stable.txt
ARG VERSION=1.21.0

RUN curl -LO "https://dl.k8s.io/release/v$VERSION/bin/linux/amd64/kubectl" && \
    curl -LO "https://dl.k8s.io/v$VERSION/bin/linux/amd64/kubectl.sha256" && \
    echo "$(<kubectl.sha256) kubectl" | sha256sum --check && \
    chmod +x kubectl

FROM ${BASE_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}

RUN microdnf --disableplugin=subscription-manager install --nodocs shadow-utils && \
    microdnf --disableplugin=subscription-manager update && \
    microdnf --disableplugin=subscription-manager clean all && \
    rm -rf /var/cache/yum

COPY --from=builder /kubectl /usr/local/bin/
COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER 1000

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["kubectl"]
