## docker-pyqt5   ## Dockerfile for Python 3 + PyQt5 applications with X11 support
## (c) 2021-2022  ## A. Shavykin <0.delameter@gmail.com>
##----------------##--------------------------------------------------------------
.ONESHELL:
.PHONY: help

DOTENV = .env
DOTENV_DIST = .env.dist

include ${DOTENV_DIST}
-include ${DOTENV}
export
VERSION ?= 0.0.0

BOLD   := $(shell tput -Txterm bold)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
NOW    := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')


help: ## show help
		@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v @fgrep | sed -Ee 's/^(##)\s*([^#]+)#*\s*(.*)/\1${YELLOW}\2${RESET}#\3/' -e 's/(.+):(#|\s)+(.+)/##   ${GREEN}\1${RESET}#\3/' | column -t -s '#'

build: ## build docker image
		docker build --build-arg VERSION=${VERSION} --build-arg BUILD_DATE=${NOW} -t ${IMAGE}:${VERSION} .
		docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest

release: ## push docker image
		docker push ${IMAGE}:${VERSION}
		docker push ${IMAGE}:latest
