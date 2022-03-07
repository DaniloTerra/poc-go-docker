.DEFAULT_GOAL = build

fmt:
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} golang:1.17 go fmt ./...
.PHONY:fmt

lint: fmt
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} golangci/golangci-lint:v1.14 golangci-lint run ./...
.PHONY:lint

vet: fmt
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} golang:1.17 go vet ./...
.PHONY:vet

run: fmt
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} golang:1.17 go run main.go
.PHONY:run

build: vet lint
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} golang:1.17 go build main.go
.PHONY:build

exec: build
	@docker run --rm -v ${PWD}:${PWD} -w ${PWD} ubuntu:focal ./main
.PHONY:exec
