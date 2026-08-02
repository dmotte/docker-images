# syntax=docker/dockerfile:1

# Tested with docker.io/library/alpine:3.24.1
FROM docker.io/library/alpine:latest

RUN <<'EOF' /bin/sh -e
    apk add --no-cache tini bash su-exec coreutils findutils openssh-server

    install -dvm755 /opt/userngo /opt/sshset /opt/sshset/data \
        /opt/portfwd-server
EOF

ADD --chown=root:root --chmod=755 \
    --checksum=sha256:ac8a2f8871dcca6e356f20507ab54ca62acf2d1163684aa824dec755c156bc1a \
    https://raw.githubusercontent.com/dmotte/misc/refs/heads/main/scripts/userngo/userngo-alpine.sh \
    /opt/userngo/main.sh

ADD --chown=root:root --chmod=755 \
    --checksum=sha256:977ab60310f3882f34874a828413b5711f7632b229226668b2bb5b45ff0783e8 \
    https://raw.githubusercontent.com/dmotte/misc/refs/heads/main/scripts/sshset/sshset.sh \
    /opt/sshset/main.sh

COPY --chown=root:root --chmod=755 *.sh /opt/portfwd-server/

ENV SSHSET_SETUP_SERVER=true

ENTRYPOINT ["/sbin/tini", "--", "/bin/bash", "/opt/userngo/main.sh", \
    "/bin/bash", "/opt/portfwd-server/entrypoint.sh"]
