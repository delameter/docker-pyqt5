# docker-pyqt5

## Dockerfile for Python 3 + PyQt5 apps with X11 support

[DockerHub](https://hub.docker.com/repository/docker/delameter/pyqt5) | [GitHub](https://github.com/delameter/docker-pyqt5) | [Changelog](https://github.com/delameter/docker-pyqt5/blob/master/CHANGES.rst)

Based on [jozo/pyqt5:1.0](https://hub.docker.com/r/jozo/pyqt5). Includes:
  - pip
  - pyqt5
  - pyqt5.qtmultimedia
  - pyqt5.qtx11extras
  - [dumb-init](https://github.com/Yelp/dumb-init)

Run this command from the sources directory to make sure everything works as supposed to:
```shell
docker run --rm \
    -e DISPLAY=$DISPLAY \
    -u $(id -u):$(id -g) \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v ./test.py:/tmp/test.py \
    delameter/pyqt5:latest \
    python3 /tmp/test.py
```

<img align="right" src="https://github.com/delameter/docker-pyqt5/assets/50381946/300ef213-e4e0-43fb-b1ce-609469fdcad5">

Or just execute `test.sh`, which contains the very same command.
The result should look like on a screenshot to the right.


### Development

Clone the repository, create the configuration file:

```shell 
git clone git@github.com:delameter/docker-pyqt5.git
cd docker-pyqt5
make prepare 
```

This will create local configuration file `.env`, which determines target docker repository, image name and version. Build the image:

```shell
make build
```

Push the image to the registry:

```shell
make publish
```
