.PHONY: clean check test build

export GO111MODULE=on

TAG_NAME := $(shell git tag -l --contains HEAD)
SHA := $(shell git rev-parse HEAD)
VERSION := $(if $(TAG_NAME),$(TAG_NAME),$(SHA))

default: clean check test build

clean:
	rm -rf dist/ builds/ cover.out

build: clean
	@echo Version: $(VERSION)
	CGO_ENABLED=0 go build -v -ldflags "-s -w -X 'main.version=${VERSION}'" -trimpath

test: clean
	go test -v -cover ./...

check:
	golangci-lint run

# ---

docs-build:
	hugo version
