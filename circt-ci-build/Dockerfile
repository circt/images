FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  clang lld \
  build-essential cmake make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip \
  clang-tidy-9

RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy \
        /usr/bin/clang-tidy-9 100
RUN pip3 install yapf

RUN apt-get install -y zlib1g-dev libcurl4-openssl-dev tcl8.6-dev \
  gettext

# Ubuntu 18.04 only has git 2.17. GitHub needs git version >2.18.
RUN wget https://github.com/git/git/archive/v2.23.0.tar.gz -O /root/git.tar.gz
RUN cd /root && tar -xf git.tar.gz
RUN cd /root/git-* && make prefix=/usr/ all -j8
RUN cd /root/git-* && make prefix=/usr/ install -j8
