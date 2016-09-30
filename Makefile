all: build test

build:
	go build

fmt:
	go fmt `go list ./... | grep -v vendor`

test:
	go test `go list ./... | grep -v /vendor/`
	go vet `go list ./... | grep -v /vendor/`
	go list ./... |grep -v /vendor/ | xargs -L1 golint

build-all: test
	gox -arch="386 amd64 arm" -os="darwin linux windows" github.com/pshima/consul-snapshot

install:
	go install

cov:
	gocov test `go list ./... |grep -v /vendor/` | gocov-html > /tmp/coverage.html
	open /tmp/coverage.html
