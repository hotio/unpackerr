#!/bin/bash
version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/unpackerr/unpackerr/commits/main" | jq -re .sha) || exit 1
json=$(cat VERSION.json)
jq --sort-keys \
    --arg version "${version//v/}" \
    '.version = $version' <<< "${json}" | tee VERSION.json
