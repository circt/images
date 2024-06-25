#!/usr/bin/env bash

set -e

# Installs gRPC from source.

cd /tmp

# v1.54.2 is the version in Ubuntu 22.04
GRPC_VER=1.54.2
echo "Installing gRPC..."

if [ ! -d grpc ]; then
  git clone --recurse-submodules -b v$GRPC_VER https://github.com/grpc/grpc
fi
cd grpc
mkdir -p cmake/build
cd cmake/build
cmake -S ../.. -B . \
  -G Ninja \
  -DgRPC_INSTALL=ON \
  -DgRPC_ABSL_PROVIDER=package \
  -DCMAKE_BUILD_TYPE=Release
ninja -j$(nproc)
cmake --install .

echo "Done."
