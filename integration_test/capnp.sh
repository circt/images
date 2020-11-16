#!/bin/bash
# Downloads, compiles, and installs CapnProto into /usr

CAPNP_VER=0f1bf4fce79923fb4974aa55a53e26450f83f286

git clone https://github.com/capnproto/capnproto.git /tmp/capnp
cd /tmp/capnp
git checkout $CAPNP_VER
cd c++
autoreconf -i
./configure --prefix=/usr
make -j$(nproc)
make install
