FROM quay.io/pypa/manylinux2014_x86_64

RUN yum install -y wget ninja-build
COPY get-capnp.sh /tmp
RUN cd /tmp && bash get-capnp.sh
