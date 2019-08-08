#!/bin/bash

set -xe

# https://stackoverflow.com/questions/6842687/the-remote-end-hung-up-unexpectedly-while-git-cloning
# git config --global http.postBuffer 1048576000

git -C ws clone https://github.com/qt/qt5.git -b 5.9

git -C ws/qt5 submodule update --init qtbase
git -C ws/qt5 submodule update --init qtdeclarative
