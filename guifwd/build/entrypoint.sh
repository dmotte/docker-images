#!/bin/bash

set -e

find /tmp -mindepth 1 -delete

export XDG_RUNTIME_DIR=/tmp/runtime-default
# Very permissive mode, to allow any user to use it freely
install -dvm777 "$XDG_RUNTIME_DIR"

# We don't use "xargs" here because we want to use Bash's builtin "kill"
trap 'builtin kill $(jobs -p) 2>/dev/null || :; wait' EXIT

if [ -e /opt/guifwd/host/wayland.sock ]; then
    # We need to use Waypipe instead of socat for Wayland, because
    # Wayland relies on file descriptor passing

    echo 'Starting Waypipe for the Wayland socket'
    XDG_RUNTIME_DIR=/opt/guifwd/host WAYLAND_DISPLAY=wayland.sock \
        waypipe -s/tmp/waypipe.sock client &

    while :; do # Shouldn't be strictly required, but good practice
        [ -e /tmp/waypipe.sock ] && break
        echo 'Waiting for /tmp/waypipe.sock existence'
        sleep 0.5
    done
fi

if [ -e /opt/guifwd/host/x11.sock ]; then
    install -dvm777 /tmp/.X11-unix

    echo 'Starting socat for the X11 socket'
    socat UNIX-LISTEN:/tmp/.X11-unix/X0,mode=666,fork,unlink-early \
        UNIX-CONNECT:/opt/guifwd/host/x11.sock &

    export DISPLAY=:0
fi

if [ -e /opt/guifwd/host/x11.xauth ]; then
    install -Tvm644 /opt/guifwd/host/x11.xauth /tmp/.Xauthority

    export XAUTHORITY=/tmp/.Xauthority
fi

# We don't use "exec" here because we may have jobs running in the
# background and we want the EXIT trap to run before exiting
if [ -e /opt/guifwd/host/wayland.sock ]; then
    # We use Waypipe's "-n" ("--no-gpu") flag to be on the safe side
    # shellcheck disable=SC2016
    waypipe -ns/tmp/waypipe.sock server -- bash -ec '
        chmod -v 666 "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"
        exec bash /opt/userngo/main.sh /opt/guifwd/shell.sh'
else
    bash /opt/userngo/main.sh /opt/guifwd/shell.sh
fi
