#!/bin/bash

docker run --rm \
    -e DISPLAY=$DISPLAY \
    -u $(id -u):$(id -g) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    delameter/pyqt5:latest \
    python3 /tmp/test.py
