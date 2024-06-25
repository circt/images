#!/bin/bash

set -e

ABSL_VER=20220623.1

cd /tmp
git clone --recurse-submodules -b $ABSL_VER https://github.com/abseil/abseil-cpp.git
cd abseil-cpp

mkdir -p build
cd build
cmake -S .. -B . \
  -G Ninja \
  -DCMAKE_CXX_STANDARD=14 \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_BUILD_TYPE=Release
ninja -j$(nproc)
cmake --install .
