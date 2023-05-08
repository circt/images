FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  lsb-release software-properties-common \
  build-essential ccache make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  git yosys clang-tidy libsystemc-dev valgrind gperf

RUN apt-get update && apt-get install -y \
  python3.8-dev python3-pip python3.9-dev

RUN python3.8 -m pip install pycapnp psutil pybind11==2.9.1 numpy jinja2 cocotb cocotb_test
RUN python3.9 -m pip install pycapnp psutil pybind11==2.9.1 numpy jinja2 cocotb cocotb_test

RUN apt-get update && apt-get install -y tcl

# Install latest release of LLVM
RUN wget https://apt.llvm.org/llvm.sh; \
    chmod +x llvm.sh; \
    ./llvm.sh 13;\
    apt install -y clang-format-13 clang-tidy-13

RUN ln -s /usr/bin/clang-13 /usr/bin/clang;\
    ln -s /usr/bin/clang++-13 /usr/bin/clang++;\
    ln -s /usr/bin/clang-tidy-13 /usr/bin/clang-tidy;\
    ln -s /usr/bin/clang-tidy-diff-13.py /usr/bin/clang-tidy-diff;\
    ln -s /usr/bin/clang-format-13 /usr/bin/clang-format;\
    ln -s /usr/bin/clang-format-diff-13 /usr/bin/clang-format-diff;\
    ln -s /usr/bin/git-clang-format-13 /usr/bin/git-clang-format;\
    ln -s /usr/bin/lld-13 /usr/bin/lld;\
    ln -s /usr/bin/lld-13 /usr/bin/ld.lld

COPY *.sh /tmp/

# Install modern release of CMake
RUN /tmp/cmake.sh

# Compile, install, then cleanup Cap'nProto
RUN /tmp/capnp.sh
RUN rm -r /tmp/capnp

# Compile, install, then cleanup Verilator
RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*

# Compile, install, then cleanup OR-Tools
RUN /tmp/or-tools.sh
RUN rm -r /tmp/or-tools-*

# Compile, install, then cleanup iverilog
run /tmp/iverilog.sh
run rm -r /tmp/iverilog-*

# Install a modern release of Z3
RUN /tmp/z3.sh

# Create manylinux compatible directory structure.
RUN mkdir -p /opt/python/cp38-cp38/bin; \
    ln -s /usr/bin/python3.8 /opt/python/cp38-cp38/bin/python; \
    ln -s /usr/bin/pip /opt/python/cp38-cp38/bin/pip; \
    mkdir -p /opt/python/cp39-cp39/bin; \
    ln -s /usr/bin/python3.9 /opt/python/cp39-cp39/bin/python; \
    ln -s /usr/bin/pip /opt/python/cp39-cp39/bin/pip
