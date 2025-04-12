#!/bin/bash

set -e

# This script should be run automatically by the CI/CD

cd "$(dirname "$0")"

for i in */cicd.sh; do
    echo "########## RUNNING $i"

    CICD_SUMMARY_TITLE="## &#x1F680; Docker image CI/CD summary - \`$(dirname "$i")\`" \
        bash "$i"

    echo
done
