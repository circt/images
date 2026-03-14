FROM ubuntu:24.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool git \
  lsb-release software-properties-common \
  build-essential make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip valgrind

RUN python3 -m pip config set global.break-system-packages true
RUN pip3 install yapf toml GitPython psutil

# Install a more recent release of LLVM
RUN wget https://apt.llvm.org/llvm.sh \
  && chmod +x llvm.sh \
  && ./llvm.sh 21 \
  && apt-get update \
  && apt install -y clang-format-21 clang-tidy-21

RUN ln -s /usr/bin/clang-21 /usr/bin/clang; \
  ln -s /usr/bin/clang++-21 /usr/bin/clang++; \
  ln -s /usr/bin/clang-tidy-21 /usr/bin/clang-tidy; \
  ln -s /usr/bin/clang-tidy-diff-21.py /usr/bin/clang-tidy-diff; \
  ln -s /usr/bin/clang-format-21 /usr/bin/clang-format; \
  ln -s /usr/bin/clang-format-diff-21 /usr/bin/clang-format-diff; \
  ln -s /usr/bin/git-clang-format-21 /usr/bin/git-clang-format; \
  ln -s /usr/bin/lld-21 /usr/bin/lld; \
  ln -s /usr/bin/lld-21 /usr/bin/ld.lld

# Install GCC 11 to get C++20 header support and support for building slang
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt install -y g++-11

ADD https://github.com/Kitware/CMake/releases/download/v3.25.2/cmake-3.25.2-linux-x86_64.sh /tmp/cmake_install.sh
RUN bash /tmp/cmake_install.sh --prefix=/usr/local --skip-license
