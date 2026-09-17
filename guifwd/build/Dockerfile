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
    --checksum=sha256:3e290185e3b6a7b4fd985c87bf1f45b9f82a474b7c87b2d0357b42aff9f9a7d1 \
    https://raw.githubusercontent.com/dmotte/misc/refs/heads/main/scripts/userngo/userngo-debian.sh \
    /opt/userngo/main.sh

COPY --chown=root:root --chmod=755 *.sh /opt/guifwd/

# Force UTF-8 to avoid encoding warnings from some tools (e.g. Perl)
ENV LC_ALL=C.UTF-8

ENTRYPOINT ["/usr/bin/tini", "--", "/bin/bash", "/opt/guifwd/entrypoint.sh"]
