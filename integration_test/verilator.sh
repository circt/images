#!/bin/bash
# Downloads, compiles, and installs Verilator into $/ext

VERILATOR_VER=4.110

cd /tmp
wget https://github.com/verilator/verilator/archive/v$VERILATOR_VER.tar.gz
tar -zxf v$VERILATOR_VER.tar.gz
rm v$VERILATOR_VER.tar.gz
cd verilator-$VERILATOR_VER
autoconf
./configure --prefix=/usr
make -j$(nproc)
make install
