FROM ubuntu:20.04

ARG USER=app
ARG GROUP=app
ARG UID=1000
ARG GID=1000
ARG APP_ROOT=/app

ENV DEBIAN_FRONTEND=noninteractive
ENV LIBGL_ALWAYS_INDIRECT=1

ENV PATH=${PATH}:${APP_ROOT}
ENV XDG_RUNTIME_DIR=${APP_ROOT}

MAINTAINER delameter <0.delameter@gmail.com>
LABEL org.opencontainers.image.source=https://github.com/delameter/docker-pyqt5
LABEL org.opencontainers.image.authors="A. Shavykin"

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
                       python3-pyqt5.qtx11extras \
                       dumb-init && \
    rm -rf /var/cache/apt/archives
RUN pip install --no-cache-dir --upgrade pip

WORKDIR ${APP_ROOT}

ARG VERSION=0
ARG BUILD_DATE=0
ENV BASE_IMAGE_BUILD_DATE=${BUILD_DATE}
ENV BASE_IMAGE_VERSION=${VERSION}
LABEL org.opencontainers.image.created=${BUILD_DATE}
LABEL org.opencontainers.image.version=${VERSION}

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["python3", "-V"]
