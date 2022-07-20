FROM ghcr.io/circt/images/circt-integration-test:v10.3
ARG circtHash

# Checkout CIRCT and LLVM
RUN git clone https://github.com/circt/circt.git /tmp/circt && \
  cd /tmp/circt && \
  git checkout $circtHash && \
  git submodule update --init --depth 1

# Build LLVM into llvm/build and llvm/build/install
RUN cd /tmp/circt && \
  mkdir -p llvm/build && \
  mkdir -p llvm/build/install && \
  cd llvm/build && \
  cmake ../llvm \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_INSTALL_PREFIX=../build/install \
    -DLLVM_BUILD_EXAMPLES=OFF \
    -DLLVM_ENABLE_ASSERTIONS=ON \
    -DLLVM_ENABLE_BINDINGS=OFF \
    -DLLVM_ENABLE_LLD=ON \
    -DLLVM_ENABLE_OCAMLDOC=OFF \
    -DLLVM_ENABLE_PROJECTS='mlir' \
    -DLLVM_INSTALL_UTILS=ON \
    -DLLVM_OPTIMIZED_TABLEGEN=ON \
    -DLLVM_TARGETS_TO_BUILD="host" && \
  cmake --build . --target install -- -j$(nproc)

# Build CIRCT and install it in /usr
RUN mkdir /tmp/circt/build && \
  cd /tmp/circt/build && cmake -G Ninja .. \
  -DMLIR_DIR=llvm/build/lib/cmake/mlir \
  -DLLVM_DIR=llvm/build/lib/cmake/llvm \
  -DCMAKE_C_COMPILER=clang \
  -DCMAKE_CXX_COMPILER=clang++ \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DVERILATOR_PATH=/usr/bin/verilator \
  -DCAPNP_PATH=/usr \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=/usr && \
  ninja -j$(nproc) && \
  ninja -j$(nproc) check-circt && \
  ninja -j$(nproc) install

# Cleanup to save space
RUN rm -rf /tmp/circt
