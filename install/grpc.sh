#!/bin/bash -xe

GRPC_VER=1.54.2
# v1.54.2 is the version in Ubuntu 22.04

cd /tmp

if [ ! -d grpc ]; then
  git clone --recurse-submodules -b v$GRPC_VER https://github.com/grpc/grpc
fi
cd grpc
mkdir -p cmake/build
cd cmake/build
cmake -S ../.. -B . \
  -G Ninja \
  -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
  -DgRPC_INSTALL=ON \
  -DCMAKE_BUILD_TYPE=Release
ninja -j$(nproc)
ninja install

# Cleanup
cd /tmp
rm -r grpc
