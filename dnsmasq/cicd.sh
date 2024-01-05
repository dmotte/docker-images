#!/bin/bash

set -e

cd "$(dirname "$0")"

IMG_AUTHOR=dmotte IMG_NAME=dnsmasq \
IMG_DESCRIPTION='dnsmasq on alpine' \
IMG_FULL_DESCRIPTION_FILE=../dockerhub-description.md \
IMG_PLATFORMS=linux/386,linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64 \
CICD_VERSION_EXPR='version_by_expr $CICD_GIT_REF '\''echo "v$(docker run --rm "$TMP_IMG" -v | head -1 | cut -d" " -f3)"'\' \
bash "$CICD_SCRIPTS_DIR/docker-img.sh"
