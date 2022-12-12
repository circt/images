FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool git \
  lsb-release software-properties-common \
  build-essential cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip

RUN pip3 install yapf toml GitPython

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
