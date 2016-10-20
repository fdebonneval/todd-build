VERSION    ?= master
REPOSITORY ?= todd
IMAGE      ?= $(REPOSITORY):$(VERSION)
GO_VERSION ?= 1.6

ifdef http_proxy
BUILD_OPTIONS = -e http_proxy=$(http_proxy)
endif
BUILD_OPTIONS += -e application_version=$(VERSION)
BUILD_OPTIONS += -v $$(pwd)/resources:/tmp/resources
BUILD_OPTIONS += -v /var/run/docker.sock:/var/run/docker.sock
BUILD_OPTIONS += -it ubuntu:16.04
BUILD_OPTIONS += /bin/bash /tmp/resources/build

build:
	# Check if todd image exists before starting a new build
	@docker images | grep todd && \
	  docker rmi todd || \
	  docker run --rm $(BUILD_OPTIONS)

