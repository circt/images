#!/bin/bash
# Downloads, compiles, and installs Yosys

YOSYS_VER=0.47

cd /tmp
wget https://github.com/YosysHQ/yosys/archive/refs/tags/$YOSYS_VER.tar.gz
tar -zxf $YOSYS_VER.tar.gz
rm $YOSYS_VER.tar.gz
cd yosys-$YOSYS_VER
make PREFIX=/usr -j$(nproc)
make PREFIX=/usr install
cd ..
rm -r yosys-$YOSYS_VER
