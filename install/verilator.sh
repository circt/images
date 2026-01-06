#!/bin/bash -xe

VERILATOR_VER=5.040

cd /tmp
wget https://github.com/verilator/verilator/archive/v$VERILATOR_VER.tar.gz
tar -zxf v$VERILATOR_VER.tar.gz
cd verilator-$VERILATOR_VER
autoconf
./configure --prefix=/usr
make -j$(nproc)
make install

# Cleanup
cd /tmp
rm v$VERILATOR_VER.tar.gz
rm -r verilator-$VERILATOR_VER

# Sanity check
verilator --version | grep "Verilator $VERILATOR_VER"
