FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  clang lld \
  build-essential cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3.8 python3-pip python3.9 \
  git yosys

RUN python3 -m pip install pycapnp psutil pybind11~=2.6 numpy

COPY *.sh /tmp/

# Compile, install, then cleanup Cap'nProto
RUN /tmp/capnp.sh
RUN rm -r /tmp/capnp

# Compile, install, then cleanup Verilator
RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*
