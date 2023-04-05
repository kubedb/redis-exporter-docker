SHELL=/bin/bash -o pipefail

REGISTRY     ?= ghcr.io/kubedb
BIN          := redis_exporter
IMAGE        := $(REGISTRY)/$(BIN)
TAG          := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

SOURCE_IMAGE := oliver006/redis_exporter:v1.9.0-alpine

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull $(SOURCE_IMAGE)
	docker tag $(SOURCE_IMAGE) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo version=$(VERSION)
