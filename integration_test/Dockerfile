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

RUN python3.8 -m pip install pycapnp psutil pybind11==2.11.2 numpy jinja2 cocotb cocotb_test
RUN python3.9 -m pip install pycapnp psutil pybind11==2.11.2 numpy jinja2 cocotb cocotb_test

RUN apt-get update && apt-get install -y tcl

# Install a more recent release of LLVM
RUN wget https://apt.llvm.org/llvm.sh; \
  chmod +x llvm.sh; \
  ./llvm.sh 17;\
  apt install -y clang-format-17 clang-tidy-17

RUN ln -s /usr/bin/clang-17 /usr/bin/clang; \
  ln -s /usr/bin/clang++-17 /usr/bin/clang++; \
  ln -s /usr/bin/clang-tidy-17 /usr/bin/clang-tidy; \
  ln -s /usr/bin/clang-tidy-diff-17.py /usr/bin/clang-tidy-diff; \
  ln -s /usr/bin/clang-format-17 /usr/bin/clang-format; \
  ln -s /usr/bin/clang-format-diff-17 /usr/bin/clang-format-diff; \
  ln -s /usr/bin/git-clang-format-17 /usr/bin/git-clang-format; \
  ln -s /usr/bin/lld-17 /usr/bin/lld; \
  ln -s /usr/bin/lld-17 /usr/bin/ld.lld

# Install GCC 11 to get C++20 header support and support for building slang
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt install -y g++-11

COPY *.sh /tmp/

# Install modern release of CMake
RUN /tmp/cmake.sh

# Compile, install, then cleanup Verilator
RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*

# Compile, install, then cleanup gRPC
# RUN /tmp/grpc.sh
# RUN rm -r /tmp/grpc

# Compile, install, then cleanup OR-Tools
RUN /tmp/or-tools.sh
RUN rm -r /tmp/or-tools-*

# Compile, install, then cleanup iverilog
RUN /tmp/iverilog.sh
RUN rm -r /tmp/iverilog-*

# Install a modern release of Z3
RUN /tmp/z3.sh

# Install Yosys.
RUN /tmp/yosys.sh

# Install SymbiYosys.
RUN /tmp/sby.sh

# Create manylinux compatible directory structure.
RUN mkdir -p /opt/python/cp38-cp38/bin; \
  ln -s /usr/bin/python3.8 /opt/python/cp38-cp38/bin/python; \
  ln -s /usr/bin/pip /opt/python/cp38-cp38/bin/pip; \
  mkdir -p /opt/python/cp39-cp39/bin; \
  ln -s /usr/bin/python3.9 /opt/python/cp39-cp39/bin/python; \
  ln -s /usr/bin/pip /opt/python/cp39-cp39/bin/pip
