IMAGE_NAME ?= lool
IMAGE_TAG ?= master

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m|sed 's/v7l//'` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

all: poco libreoffice lool

poco: .dapper
	cd dapper/poco && $(CURDIR)/.dapper build 2>&1

lool: .dapper
	cd dapper/online && $(CURDIR)/.dapper -m bind -C .. -f online/Dockerfile.dapper build 2>&1

libreoffice: .dapper
	cd dapper/core && $(CURDIR)/.dapper -m bind build 2>&1

release: | dapper/online/build
	docker build -t ${IMAGE_NAME}:${IMAGE_TAG} dapper/

clean-libreoffice: .dapper
	cd dapper/core && $(CURDIR)/.dapper -m bind clean 2>&1

clean-lool: .dapper
	cd dapper/online && $(CURDIR)/.dapper -m bind clean 2>&1

clean-poco:
	@rm -rf dapper/poco/build

clean:
	@./scripts/clean

archive-libreoffice:
	@tar -C dapper/core -cf lo.tar build
	brotli --force --best ./lo.tar

restore-libreoffice:
	brotli -d ./lo.tar.br
	@tar -C dapper/core -xf lo.tar

change-version:
	@./scripts/change-version

get-source:
	@./scripts/get-source

update:
	@./scripts/update

.PHONY: clean-libreoffice clean-lool clean-poco archive-libreoffice clean