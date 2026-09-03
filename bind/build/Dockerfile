# syntax=docker/dockerfile:1

# Tested with docker.io/library/alpine:3.24.1
FROM docker.io/library/alpine:latest

RUN <<'EOF' /bin/sh -e
    apk add --no-cache bind bind-dnssec-tools

    rm -v /etc/bind/rndc.key # Remove auto-generated rndc.key
EOF

EXPOSE 53 53/udp

ENTRYPOINT ["/usr/sbin/named", "-gc/etc/bind/named.conf", "-unamed"]
