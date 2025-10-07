FROM quay.io/pypa/manylinux_2_28_x86_64

RUN yum install -y \
  wget ninja-build autoconf bc bison flex flex-devel perl \
  python3 python3-devel

COPY *.sh /tmp/

RUN /tmp/verilator.sh
RUN rm -r /tmp/verilator-*

# Compile, install, then cleanup gRPC
RUN /tmp/grpc.sh
RUN rm -r /tmp/grpc

# Install sccache
ENV sccache_version=0.5.4
RUN wget --progress=dot:mega https://github.com/mozilla/sccache/releases/download/v${sccache_version}/sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN tar -zxf sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN cp sccache-v${sccache_version}-$(arch)-unknown-linux-musl/sccache /usr/bin
