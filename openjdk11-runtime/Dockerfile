FROM registry.access.redhat.com/ubi8/openjdk-11-runtime:1.9-3

COPY tools/ /opt/tools/

USER root
RUN chown jboss /usr/lib/jvm/jre/lib/security/cacerts && \
    chmod u+w /usr/lib/jvm/jre/lib/security/cacerts
USER jboss

ENTRYPOINT [ "/opt/tools/entrypoint.sh" ]
# CMD [ "/opt/jboss/container/java/run" ]
