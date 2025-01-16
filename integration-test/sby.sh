#!/bin/bash
# Downloads, compiles, and installs SymbiYosys
set -xe

YOSYS_VER=0.47

cd /tmp
wget https://github.com/YosysHQ/sby/archive/refs/tags/yosys-$YOSYS_VER.tar.gz
tar -zxf yosys-$YOSYS_VER.tar.gz
rm yosys-$YOSYS_VER.tar.gz
cd sby-yosys-$YOSYS_VER
make PREFIX=/usr install
cd ..
rm -r sby-yosys-$YOSYS_VER

# Perform a sanity check.
cat > /tmp/sanity.v <<EOF
module Foo(a);
  input [7:0] a;
  assert property (a * 2 == a + a);
endmodule
EOF

sby <<EOF
[options]
mode prove

[engines]
smtbmc z3

[script]
read -formal /tmp/sanity.v
prep -top Foo
EOF
