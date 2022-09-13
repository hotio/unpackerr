#!/bin/bash

version=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/davidnewhall/unpackerr/releases" | jq -r .[0].tag_name | sed s/v//g)
[[ -z ${version} ]] && exit 0
old_version=$(jq -r '.version' < VERSION.json)
changelog=$(jq -r '.changelog' < VERSION.json)
[[ "${old_version}" != "${version}" ]] && changelog="https://github.com/davidnewhall/unpackerr/compare/v${old_version}...v${version}"
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .changelog = "'"${changelog}"'"' <<< "${version_json}" > VERSION.json
