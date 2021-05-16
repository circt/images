FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install apt-utils -y
RUN apt-get upgrade -y
RUN apt-get update && apt-get install -y \
  man curl wget unzip tar ca-certificates libtool \
  clang lld \
  build-essential make ninja-build pkg-config \
  autoconf bc bison flex libfl2 libfl-dev perl libssl-dev \
  python3 python3-pip \
  clang-format clang-tidy-9 git cmake

RUN update-alternatives --install /usr/bin/clang-tidy clang-tidy \
        /usr/bin/clang-tidy-9 100
RUN pip3 install yapf
