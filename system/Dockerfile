FROM ubuntu:12.04

RUN apt-get update
RUN apt-get install -y make bison git vim gcc-4.5 g++-4.5
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.5 10
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.5 10
RUN apt-get install -y ninja-build strace wget

ADD https://cmake.org/files/v3.7/cmake-3.7.2-Linux-x86_64.sh /cmake-3.7.2-Linux-x86_64.sh
RUN mkdir /opt/cmake
RUN sh /cmake-3.7.2-Linux-x86_64.sh --prefix=/opt/cmake --skip-license
RUN ln -s /opt/cmake/bin/cmake /usr/local/bin/cmake

ARG UNAME=shrkamat
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME
WORKDIR /home/shrkamat
