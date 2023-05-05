#!/bin/bash
# Downloads, compiles, and installs iverilog

cd /tmp

IVERILOG_VER=11_0
wget https://github.com/steveicarus/iverilog/archive/refs/tags/v${IVERILOG_VER}.tar.gz
tar -zxf v$IVERILOG_VER.tar.gz
cd iverilog-$IVERILOG_VER
autoconf
./configure --prefix=/usr
make -j$(nproc)
make install
