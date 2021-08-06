FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  build-essential ccache cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  git yosys

RUN apt-get update && apt-get install -y \
  python3.8-dev python3-pip python3.9-dev

RUN python3.8 -m pip install pycapnp psutil pybind11==2.6.2 numpy
RUN python3.9 -m pip install pycapnp psutil pybind11==2.6.2 numpy

# Install latest release of LLVM
RUN wget https://apt.llvm.org/llvm.sh; \
    chmod +x llvm.sh; \
    ./llvm.sh 12;\
    apt install -y clang-format-12 clang-tidy-12

RUN ln -s /usr/bin/clang-12 /usr/bin/clang;\
    ln -s /usr/bin/clang++-12 /usr/bin/clang++;\
    ln -s /usr/bin/clang-tidy-12 /usr/bin/clang-tidy;\
    ln -s /usr/bin/clang-tidy-diff-12.py /usr/bin/clang-tidy-diff;\
    ln -s /usr/bin/clang-format-12 /usr/bin/clang-format;\
    ln -s /usr/bin/clang-format-diff-12 /usr/bin/clang-format-diff;\
    ln -s /usr/bin/lld-12 /usr/bin/lld

COPY *.sh /tmp/

# Compile, install, then cleanup Cap'nProto
RUN /tmp/capnp.sh
RUN rm -r /tmp/capnp

# Compile, install, then cleanup Verilator
RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*
