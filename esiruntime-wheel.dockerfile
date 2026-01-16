FROM quay.io/pypa/manylinux_2_28_x86_64

RUN yum install -y \
  wget ninja-build autoconf bc bison flex flex-devel perl \
  python3 python3-devel

# Downgrade to gcc-10 for Ubuntu 22.04 compat.
RUN dnf remove -y gcc-toolset-14*
RUN dnf install -y gcc-toolset-10
RUN echo "source scl_source enable gcc-toolset-10" >> /etc/bashrc


# Install tools
COPY install/*.sh /tmp/
RUN /tmp/grpc.sh
