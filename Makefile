SHELL=/bin/bash -o pipefail

REGISTRY   ?= kubedb
BIN        := redis_exporter
IMAGE      := $(REGISTRY)/$(BIN)
DB_VERSION := v0.21.1
TAG        := $(shell git describe --exact-match --abbrev=0 2>/dev/null || echo "")

.PHONY: push
push: container
	docker push $(IMAGE):$(TAG)

.PHONY: container
container:
	docker pull oliver006/redis_exporter:$(DB_VERSION)
	docker tag oliver006/redis_exporter:$(DB_VERSION) $(IMAGE):$(TAG)

.PHONY: version
version:
	@echo ::set-output name=version::$(TAG)
