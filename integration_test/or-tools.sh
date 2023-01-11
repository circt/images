#!/bin/bash
# Downloads, compiles, and installs OR-Tools into /usr

OR_TOOLS_VER=9.5

# Disable fetching and building SCIP below because of its license:
#  "SCIP is distributed under the ZIB Academic License. You are allowed to
#   retrieve SCIP for research purposes as a member of a non-commercial or
#   academic institution."

cd /tmp
wget https://github.com/google/or-tools/archive/v$OR_TOOLS_VER.tar.gz
tar -zxf v$OR_TOOLS_VER.tar.gz
rm v$OR_TOOLS_VER.tar.gz
cd or-tools-$OR_TOOLS_VER
cmake -S . -B build -DBUILD_DEPS=ON -DBUILD_SAMPLES=OFF -DBUILD_EXAMPLES=OFF -DBUILD_FLATZINC=OFF -DUSE_SCIP=OFF
cmake --build build --parallel $(nproc)
cmake --install build --prefix /usr
