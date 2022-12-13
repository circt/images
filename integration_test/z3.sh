#!/bin/bash
# Installs Z3 into "/usr/local"; this directory has precedence among the default
# $PATH locations and will shadow the "/usr" installation.

Z3_VER=4.11.2

function compile_Z3 {
  git clone https://github.com/Z3Prover/z3.git /tmp/z3
  cd /tmp/z3
  git checkout z3-${Z3_VER}
  mkdir build
  cd build
  # Compile the shared library with the appropriate install prefix
  # and proceed with installing.
  cmake -G Ninja .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local/ \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DZ3_BUILD_LIBZ3_SHARED=TRUE
  ninja install
  # Cleanup.
  cd /tmp
  rm -r z3
}

function download_Z3_package {
  GLIBC_VER=2.31
  Z3_RELEASE=z3-${Z3_VER}-x64-glibc-${GLIBC_VER}
  cd /tmp
  wget https://github.com/Z3Prover/z3/releases/download/z3-${Z3_VER}/${Z3_RELEASE}.zip
  unzip ${Z3_RELEASE}.zip
  cd ${Z3_RELEASE}
  # Install into the appropriate suffixes to be discoverable
  # by LLVM's `FindZ3` CMake module.
  cp include/* /usr/local/include
  cp bin/libz3.so /usr/local/bin/libz3.so
  cp bin/z3 /usr/local/bin/z3
  # Cleanup.
  cd /tmp
  rm ${Z3_RELEASE}.zip
  rm -r ${Z3_RELEASE}
}

if [ $(uname -m) = "x86_64" ]; then
  download_Z3_package
else
  # There is no appropriate package release, resorting to compilation.
  compile_Z3
fi
