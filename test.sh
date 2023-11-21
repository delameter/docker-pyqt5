#!/bin/bash

docker run --rm \
    -e DISPLAY=$DISPLAY \
    -u $(id -u):$(id -g) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ./test.py:/tmp/test.py \
    delameter/pyqt5:latest \
    python3 /tmp/test.py
