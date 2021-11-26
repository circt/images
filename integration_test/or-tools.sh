#!/bin/bash
# Downloads, compiles, and installs OR-Tools into /usr

OR_TOOLS_VER=9.1

# Disable fetching and building SCIP because of its license:
#  "SCIP is distributed under the ZIB Academic License. You are allowed to
#   retrieve SCIP for research purposes as a member of a non-commercial or
#   academic institution."
export USE_SCIP=OFF

cd /tmp
wget https://github.com/google/or-tools/archive/v$OR_TOOLS_VER.tar.gz
tar -zxf v$OR_TOOLS_VER.tar.gz
rm v$OR_TOOLS_VER.tar.gz
cd or-tools-$OR_TOOLS_VER
make -j$(nproc) third_party
make -j$(nproc) cc
make install_cc prefix=/usr
