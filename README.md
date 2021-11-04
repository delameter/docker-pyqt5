# docker-pyqt5

### Dockerfile for Python 3 + PyQt5 applications with X11 support

[DockerHub](https://hub.docker.com/repository/docker/delameter/pyqt5) | [GitHub](https://github.com/delameter/docker-pyqt5)

Based on [jozo/pyqt5:1.0](https://hub.docker.com/r/jozo/pyqt5). Includes **pyqt5.qtmultimedia** and **pyqt5.qtx11extras**.

Execute this to make sure everything works as supposed to:
```shell
docker run -it --rm \
    -e DISPLAY=$DISPLAY \
    -u app \
    -v /tmp/.X11-unix:/tmp/.X11-unix \ 
    delameter/pyqt5:1.0.0 python3 /tmp/test.py
```
