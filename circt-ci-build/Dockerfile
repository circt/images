FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  build-essential cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip

RUN pip3 install yapf

RUN apt-get install -y zlib1g-dev libcurl4-openssl-dev tcl8.6-dev \
  gettext

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

# Ubuntu 18.04 only has git 2.17. GitHub needs git version >2.18.
RUN wget https://github.com/git/git/archive/v2.23.0.tar.gz -O /root/git.tar.gz
RUN cd /root && tar -xf git.tar.gz
RUN cd /root/git-* && make prefix=/usr/ all -j8
RUN cd /root/git-* && make prefix=/usr/ install -j8
