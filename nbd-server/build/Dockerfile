# syntax=docker/dockerfile:1

# Tested with docker.io/library/alpine:3.24.1
FROM docker.io/library/alpine:latest

RUN <<'EOF' /bin/sh -e
    apk add --no-cache nbd
EOF

EXPOSE 10809

ENTRYPOINT ["/usr/bin/nbd-server", "-n"]
