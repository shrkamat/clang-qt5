#!/bin/bash
docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) -t devsys .
docker run -it --rm -e DISPLAY=$DISPLAY -v $PWD/../ws:/home/shrkamat -v /tmp/.X11-unix/:/tmp/.X11-unix --security-opt seccomp:unconfined --cap-add sys_admin --cap-add sys_ptrace devsys

