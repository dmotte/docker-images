#!/bin/bash

set -e

# This script should be run automatically by the CI/CD

cd "$(dirname "$0")"

[ "$GITHUB_EVENT_NAME" != schedule ] && git diff --quiet HEAD^ HEAD -- . && {
    echo "Skipping $0 as there are no changes in $PWD in the latest commit" \
        'and this is not a scheduled run'
    exit
}

IMG_AUTHOR=dmotte IMG_NAME=guifwd \
IMG_DESCRIPTION='Run graphical applications in a Docker container' \
IMG_FULL_DESCRIPTION_FILE=../dockerhub-description.md \
IMG_PLATFORMS=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64 \
exec bash "$CICD_SCRIPTS_DIR/docker-img.sh"
