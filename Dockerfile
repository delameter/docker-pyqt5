FROM ubuntu:20.04

ARG USER=app
ARG GROUP=app
ARG UID=1000
ARG GID=1000

MAINTAINER delameter <0.delameter@gmail.com>
LABEL org.opencontainers.image.source=https://github.com/delameter/docker-pyqt5
LABEL org.opencontainers.image.authors="A. Shavykin"

ENV DEBIAN_FRONTEND=noninteractive
ENV LIBGL_ALWAYS_INDIRECT=1

RUN addgroup --gid "${GID}" "${GROUP}" || echo 'Skipping'
RUN adduser \
        --disabled-password \
        --gecos "" \
        --home "$(pwd)" \
        --ingroup "${GROUP}" \
        --no-create-home \
        --uid "${UID}" \
        "${USER}" || echo 'Skipping'

RUN apt-get update &&\
    apt-get -y install python3-pip \
                       python3-pyqt5 \
                       python3-pyqt5.qtmultimedia \
                       python3-pyqt5.qtx11extras && \
    rm -rf /var/cache/apt/archives
RUN pip install --no-cache-dir --upgrade pip

COPY test.py /tmp/test.py

ARG VERSION=0
ARG BUILD_DATE=0
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.version=${VERSION}

CMD python /tmp/test.py
