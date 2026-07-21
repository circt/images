FROM quay.io/pypa/manylinux_2_28_x86_64

# Use dnf package manager for AlmaLinux 8
# GCC 11+ is native; devtoolset is no longer needed
RUN dnf install -y \
  wget ninja-build autoconf bc bison flex flex-devel perl \
  python3 python3-devel help2man \
  && dnf clean all

# Install tools
COPY install/*.sh /tmp/
RUN /tmp/verilator.sh

# Install sccache
ENV sccache_version=0.5.4
RUN wget --progress=dot:mega https://github.com/mozilla/sccache/releases/download/v${sccache_version}/sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz \
  && tar -zxf sccache-v${sccache_version}-$(arch)-unknown-linux-musl.tar.gz \
  && cp sccache-v${sccache_version}-$(arch)-unknown-linux-musl/sccache /usr/bin/ \
  && rm -rf sccache-v${sccache_version}-*
