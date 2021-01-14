#!/usr/bin/env bash

# Get the latest git hash using hte GitHub REST API
hash=`curl -X GET https://api.github.com/repos/llvm/circt/commits/main | jq -r '.sha'`

# Build the image
docker build --build-arg circtHash=$hash -t ghcr.io/circt/images/circt:latest .
