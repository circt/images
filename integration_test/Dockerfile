FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  clang lld \
  build-essential cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip \
  git yosys \
  libncurses5

# Specifically for ModelSimAE
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y libxext6:i386 libxft2:i386

RUN python3 -m pip install pycapnp psutil

COPY *.sh /tmp/

# Download, install, then cleanup Quartus/ModelSimAE
RUN /tmp/quartus.sh

# Compile, install, then cleanup Cap'nProto
RUN /tmp/capnp.sh
RUN rm -r /tmp/capnp

# Compile, install, then cleanup Verilator
RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*

ENV PATH="/usr/local/intelFPGA_pro/20.4/quartus/bin:/usr/local/intelFPGA_pro/20.4/modelsim_ase/bin:${PATH}"
