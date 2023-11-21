## docker-pyqt5   ## Dockerfile for Python 3 + PyQt5 applications with X11 support
## (c) 2021-2022  ## A. Shavykin <0.delameter@gmail.com>
##----------------##--------------------------------------------------------------
.ONESHELL:
.PHONY: help

DOTENV_DIST = .env.dist
DOTENV_LOCAL = .env

include ${DOTENV_DIST}
-include ${DOTENV_LOCAL}
export
VERSION ?= 0.0.0

BOLD   := $(shell tput -Txterm bold)
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
NOW    := $(shell date -u +'%Y-%m-%dT%H:%M:%SZ')


help: ## show help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v @fgrep | sed -Ee 's/^(##)\s*([^#]+)#*\s*(.*)/\1${YELLOW}\2${RESET}#\3/' -e 's/(.+):(#|\s)+(.+)/##   ${GREEN}\1${RESET}#\3/' | column -t -s '#'

help-verbose:  # show actual commands
	@if ! sh -c "command -v envsubst" >/dev/null ; then cat $(MAKEFILE_LIST) && exit ; fi
	@export FILENAME=${FILENAME} && sed -Ee '/^\S+:\s*#/!d;n' < $(MAKEFILE_LIST) | envsubst | {
		if sh -c "command -v bat" >/dev/null ; then bat -l make --decorations=never --theme TwoDark ; else cat ; fi
	}
	@echo

_cp_env = ([ ! -s $2 ] && { sed -E < $1 > $2  -e "1i\# This file has a higher priority than $1\n" -e "/^(\#|$$)/d" && echo "File created: $2" ; } || echo "Skipping: $2 already exists" ; )

prepare:  ## make local configuration file for image building
	@$(call _cp_env,$(DOTENV_DIST),$(DOTENV_LOCAL))

build: ## build docker image
	docker build \
		--build-arg VERSION=${VERSION} \
		--build-arg BUILD_DATE=${NOW} \
		-t ${IMAGE}:${VERSION} .

test: ## run test script inside a container
	./test.sh

publish: ## tag image as latest and push
	docker push ${IMAGE}:${VERSION}
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:latest
	docker push ${IMAGE}:latest
