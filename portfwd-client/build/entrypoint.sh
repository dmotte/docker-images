#!/bin/bash

set -e

# Some examples: ".5", "0.5s", "30", "30s", "5m", "1h"
readonly autorestart=${PORTFWD_CLIENT_AUTORESTART:--1}

################################################################################

bash /opt/sshset/main.sh

################################################################################

[ -e ~/.ssh/config ] || install -Tvm644 /dev/null ~/.ssh/config

echo 'Adding portfwd-client default config to ~/.ssh/config'

cat << 'EOF' >> ~/.ssh/config
# Default config for portfwd-client

SessionType none

# Equivalent to ssh "-v" flag
LogLevel DEBUG

ServerAliveInterval 30
ExitOnForwardFailure yes
EOF

################################################################################

[ "$autorestart" != -1 ] || exec /usr/bin/ssh "$@"

while :; do
    result=0
    /usr/bin/ssh "$@" || result=$?
    [ "$result" = 0 ] ||
        echo "The OpenSSH Client exited with status code $result" >&2

    echo "Sleeping $autorestart" >&2
    sleep "$autorestart"
done
