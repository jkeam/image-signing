FROM centos:8
USER 0

# The curl install of JQ is required in order to bypass requiring the EPEL repository. The URL can be mirrored in disconnected environments.
RUN yum repolist > /dev/null && \
    curl -o jq -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 && \
    chmod +x ./jq && \
    cp jq /usr/bin && \
    curl -o oc.tar.gz https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/openshift-client-linux.tar.gz && \
    tar -xvf oc.tar.gz && \
    chmod +x ./oc && \
    cp oc /usr/bin && \
    yum clean all && \
    INSTALL_PKGS="podman" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    sed 's/#mount_program/mount_program/' /etc/containers/storage.conf -i

# import keys
COPY keys/private-key.gpg keys/public-key.gpg /tmp/
RUN gpg --import /tmp/private-key.gpg && \
    gpg --import /tmp/public-key.gpg && \
    rm /tmp/private-key.gpg /tmp/public-key.gpg

# copy script
COPY sign-and-upload.sh /usr/local/
# ENTRYPOINT ["/bin/bash"]
# RUN adduser signer
# USER signer
