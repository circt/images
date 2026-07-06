FROM quay.io/pypa/manylinux2014_x86_64

RUN yum install -y devtoolset-10
RUN scl enable devtoolset-10 bash

RUN yum install -y \
  wget ninja-build autoconf bc bison flex flex-devel perl \
  python3 python3-devel help2man

# Install tools
COPY install/*.sh /tmp/
RUN /tmp/verilator.sh

# Install sccache
ENV sccache_version=0.5.4
RUN wget --progress=dot:mega https://github.com/mozilla/sccache/releases/download/v${sccache_version}/sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN tar -zxf sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN cp sccache-v${sccache_version}-$(arch)-unknown-linux-musl/sccache /usr/bin
