FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  autoconf \
  bc \
  bison \
  build-essential \
  ca-certificates \
  ccache \
  clang-tidy \
  curl \
  flex \
  gawk \
  git \
  gperf \
  help2man \
  iverilog \
  libffi-dev \
  libfl-dev \
  libfl2 \
  libreadline-dev \
  libssl-dev \
  libsystemc-dev \
  libtool \
  lsb-release \
  make \
  man \
  ninja-build \
  perl \
  pkg-config \
  software-properties-common \
  tar \
  tcl-dev \
  unzip \
  valgrind \
  wget \
  zlib1g-dev

RUN apt-get update && apt-get install -y \
  python3.12-dev python3-pip

RUN python3.12 -m pip config set global.break-system-packages true
RUN python3.12 -m pip install pycapnp psutil pybind11==2.11.2 nanobind==2.9.2 numpy jinja2 cocotb~=1.9 cocotb_test~=0.2 click

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

# Install tools
COPY install/*.sh /tmp/
RUN /tmp/cmake.sh
RUN /tmp/verilator.sh
RUN /tmp/or-tools.sh
RUN /tmp/z3.sh
RUN /tmp/yosys.sh
RUN /tmp/sby.sh

# Create manylinux compatible directory structure.
RUN mkdir -p /opt/python/cp312-cp312/bin; \
  ln -s /usr/bin/python3.12 /opt/python/cp312-cp312/bin/python; \
  ln -s /usr/bin/pip /opt/python/cp312-cp312/bin/pip;
