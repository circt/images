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
  clang-17 \
  clang-tidy-17 \
  cmake \
  curl \
  flex \
  gawk \
  gcc \
  git \
  gperf \
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
  python3.12-dev \
  python3-pip \
  software-properties-common \
  tar \
  tcl \
  tcl-dev \
  unzip \
  valgrind \
  wget \
  verilator \
  zlib1g-dev

RUN python3.12 -m pip config set global.break-system-packages true
RUN python3.12 -m pip install pycapnp psutil pybind11==2.11.2 nanobind==2.4.0 numpy jinja2 cocotb cocotb_test click

RUN update-alternatives \
  --install /usr/bin/clang clang /usr/bin/clang-17 100 \
  --slave /usr/bin/clang++ clang++ /usr/bin/clang++-17 \
  --slave /usr/bin/clang-tidy clang-tidy /usr/bin/clang-tidy-17 \
  --slave /usr/bin/clang-tidy-diff clang-tidy-diff /usr/bin/clang-tidy-diff-17.py \
  --slave /usr/bin/clang-format clang-format /usr/bin/clang-format-17 \
  --slave /usr/bin/clang-format-diff clang-format-diff /usr/bin/clang-format-diff-17 \
  --slave /usr/bin/git-clang-format git-clang-format /usr/bin/git-clang-format-17 \
  --slave /usr/bin/lld lld /usr/bin/lld-17 \
  --slave /usr/bin/ld.lld /usr/bin/lld-17

COPY *.sh /tmp/

# Compile, install, then cleanup gRPC
# RUN /tmp/grpc.sh
# RUN rm -r /tmp/grpc

# Compile, install, then cleanup OR-Tools
RUN /tmp/or-tools.sh
RUN rm -r /tmp/or-tools-*

# Install a modern release of Z3
RUN /tmp/z3.sh

# Install Yosys.
RUN /tmp/yosys.sh

# Install SymbiYosys.
RUN /tmp/sby.sh

# Create manylinux compatible directory structure.
RUN mkdir -p /opt/python/cp312-cp312/bin; \
  ln -s /usr/bin/python3.12 /opt/python/cp312-cp312/bin/python; \
  ln -s /usr/bin/pip /opt/python/cp312-cp312/bin/pip;
