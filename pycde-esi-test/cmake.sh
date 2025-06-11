#!/bin/bash
# Download and install a modern release of CMake into "/usr".

CMAKE_VER=3.23.2

# Detect the host's architecture to download the appropriate release.
case $(uname -m) in
  aarch64|arm64) BINARY_ARCH=aarch64;;
  x86_64) BINARY_ARCH=x86_64;;
esac

INSTALL_SCRIPT=cmake-$CMAKE_VER-linux-$BINARY_ARCH.sh

cd /tmp
wget https://github.com/Kitware/CMake/releases/download/v$CMAKE_VER/$INSTALL_SCRIPT
chmod +x $INSTALL_SCRIPT
./$INSTALL_SCRIPT --skip-license --prefix=/usr
rm $INSTALL_SCRIPT
