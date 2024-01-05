#!/bin/bash

set -e

for i in */cicd.sh; do
    echo "########## RUNNING $i"

    CICD_SUMMARY_TITLE="## &#x1F680; Docker image CI/CD summary - \`$(dirname "$i")\`" \
        bash "$i"

    echo
done
