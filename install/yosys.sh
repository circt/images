#!/bin/bash
# Downloads, compiles, and installs Yosys
set -xe

YOSYS_VER=0.47

mkdir -p /tmp/yosys
cd /tmp/yosys
wget https://github.com/YosysHQ/yosys/releases/download/$YOSYS_VER/yosys.tar.gz
tar -zxf yosys.tar.gz
export PREFIX=/usr
make config-clang
make -j$(nproc)
make install

# Cleanup
cd /tmp
rm -r /tmp/yosys

# Perform a sanity check.
cat > /tmp/sanity.v <<EOF
module Adder(a, b, z);
  input  [7:0] a;
  input  [7:0] b;
  output [7:0] z;
  assign z = a + b;
endmodule
EOF

yosys <<EOF
read_verilog /tmp/sanity.v
hierarchy -check
opt
EOF
