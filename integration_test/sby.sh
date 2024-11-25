#!/bin/bash
# Downloads, compiles, and installs SymbiYosys

YOSYS_VER=0.47

cd /tmp
wget https://github.com/YosysHQ/sby/archive/refs/tags/yosys-$YOSYS_VER.tar.gz
tar -zxf yosys-$YOSYS_VER.tar.gz
rm yosys-$YOSYS_VER.tar.gz
cd sby-yosys-$YOSYS_VER
make PREFIX=/usr install
cd ..
rm -r sby-yosys-$YOSYS_VER
