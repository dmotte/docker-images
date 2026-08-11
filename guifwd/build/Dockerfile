# syntax=docker/dockerfile:1

FROM docker.io/library/debian:13

RUN <<'EOF' /bin/bash -e
    apt-get update
    apt-get install -y tini gosu sudo waypipe socat
    rm -rf /var/lib/apt/lists/*

    # Force UTF-8 to avoid encoding warnings from some tools (e.g. Perl)
    printf '%s\n' '# shellcheck shell=sh' 'export LC_ALL=C.UTF-8' |
        install -Tvm644 /dev/stdin /etc/profile.d/50-c-utf8.sh

    install -dvm755 /opt/{userngo,guifwd{,/host}}
EOF

ADD --chown=root:root --chmod=755 \
    --checksum=sha256:b350a393494f8de7d51b3309d8f7f40274392826938ef73a5da9cd9631541b62 \
    https://raw.githubusercontent.com/dmotte/misc/refs/heads/main/scripts/userngo/userngo-debian.sh \
    /opt/userngo/main.sh

COPY --chown=root:root --chmod=755 *.sh /opt/guifwd/

# Force UTF-8 to avoid encoding warnings from some tools (e.g. Perl)
ENV LC_ALL=C.UTF-8

ENTRYPOINT ["/usr/bin/tini", "--", "/bin/bash", "/opt/guifwd/entrypoint.sh"]
