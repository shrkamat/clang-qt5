#!/bin/bash

# Reference
# =========
# https://stackoverflow.com/questions/25840088/how-to-build-libcxx-and-libcxxabi-by-clang-on-centos-7

# Assumes
# 1. repo sync to be successfull
# 2. clang folder to be present

set -xe

CROOT=$PWD

# clang
cd $CROOT
mkdir -p clang/build/llvm && cd clang/build/llvm
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DLLVM_TARGETS_TO_BUILD='X86' -DLLVM_ENABLE_PROJECTS='clang' -DCOMPILER_RT_BUILD_SANITIZERS=OFF -DLLVM_BUILD_RUNTIME=false -G Ninja $CROOT/clang/code/llvm
ninja install

# libcxx round 1
cd $CROOT
mkdir -p clang/build/libcxx-1 && cd clang/build/libcxx-1
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -G Ninja $CROOT/clang/code/llvm/libcxx
ninja install

# libcxxabi
# this is a very old module & is based on custom script
cd $CROOT
cd $CROOT/clang/code/llvm/libcxxabi/lib
./buildit
cp -f libc++abi.so.1.0 /usr/lib/
ln -sf /usr/lib/libc++abi.so.1.0 /usr/lib/libc++abi.so.1
ln -sf /usr/lib/libc++abi.so.1.0 /usr/lib/libc++abi.so

# libcxx round 2 (this time with newly generated libcxxabi)
cd $CROOT
mkdir -p clang/build/libcxx-2 && cd clang/build/libcxx-2
cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLIBCXX_CXX_ABI=libcxxabi -DLIBCXX_LIBCXXABI_INCLUDE_PATHS=$CROOT/clang/code/llvm/libcxxabi/include -G Ninja $CROOT/clang/code/llvm/libcxx
ninja install


# # compiler-rt
# cd $CROOT
# mkdir -p clang/build/compiler-rt && cd clang/build/compiler-rt
# cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ -DLLVM_BUILD_RUNTIME=ON $CROOT/clang/code/llvm/projects
# ninja
