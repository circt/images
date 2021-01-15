FROM ghcr.io/circt/images/circt-integration-test:v3
ARG circtHash

# Checkout CIRCT and LLVM
RUN git clone https://github.com/circt/circt.git /tmp/circt && \
  cd /tmp/circt && \
  git checkout $circtHash && \
  git submodule update --init --depth 1

# Build LLVM into llvm/build and llvm/build/install
RUN cd /tmp/circt && ./utils/build-llvm.sh build build/install

# Build CIRCT and install it in /usr
RUN mkdir /tmp/circt/build && \
  cd /tmp/circt/build && cmake -G Ninja .. \
  -DMLIR_DIR=llvm/build/lib/cmake/mlir \
  -DLLVM_DIR=llvm/build/lib/cmake/llvm \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DVERILATOR_PATH=/usr/bin/verilator \
  -DCAPNP_PATH=/usr \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=/usr && \
  ninja -j$(nproc) && \
  ninja -j$(nproc) install

# Cleanup to save space
RUN rm -rf /tmp/circt
