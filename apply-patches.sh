#!/bin/bash

patch -p1 -d ws/clang/code/llvm/libcxxabi -i $PWD/patches/libcxxabi/*.patch 

patch -p1 -d ws/qt5/qtdeclarative -i $PWD/patches/qtdeclarative/*.patch

patch -p1 -d ws/qt5/qtbase -i $PWD/patches/qtbase/*.patch
