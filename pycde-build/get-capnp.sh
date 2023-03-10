#!/usr/bin/env bash
##===- utils/get-capnp.sh - Install CapnProto ----------------*- Script -*-===##
# 
# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
# 
##===----------------------------------------------------------------------===##

set -e

mkdir -p "$(dirname "$BASH_SOURCE[0]")/../ext"
EXT_DIR=$(cd "$(dirname "$BASH_SOURCE[0]")/../ext" && pwd)
CAPNP_VER=0.9.1
echo "Installing capnproto..."

echo $EXT_DIR
cd $EXT_DIR

wget https://capnproto.org/capnproto-c++-$CAPNP_VER.tar.gz
tar -zxf capnproto-c++-$CAPNP_VER.tar.gz
cd capnproto-c++-$CAPNP_VER
./configure
make -j$(nproc)
make install
cd ../
rm -r capnproto-c++-$CAPNP_VER capnproto-c++-$CAPNP_VER.tar.gz

echo "Done."
