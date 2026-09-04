#!/bin/bash

set -e

USER=$(id -un); export USER
export HOME=~

# Needed to have the correct shell inside terminal emulator windows
SHELL=$(getent passwd "$USER" | cut -d: -f7); export SHELL

cd

exec "$SHELL"
