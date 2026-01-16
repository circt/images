FROM quay.io/pypa/manylinux_2_28_x86_64

# Downgrade to gcc-10 for Ubuntu 22.04 compat.
RUN dnf remove -y gcc-toolset-14*
RUN dnf install -y gcc-toolset-10
RUN echo "source scl_source enable gcc-toolset-10" >> /etc/bashrc

RUN dnf install -y \
  wget ninja-build autoconf bc bison flex flex-devel perl \
  python3 python3-devel

# Install tools
COPY install/*.sh /tmp/
RUN /tmp/verilator.sh
RUN /tmp/grpc.sh

# Install sccache
ENV sccache_version=0.5.4
RUN wget --progress=dot:mega https://github.com/mozilla/sccache/releases/download/v${sccache_version}/sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN tar -zxf sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz
RUN cp sccache-v${sccache_version}-$(arch)-unknown-linux-musl/sccache /usr/bin
