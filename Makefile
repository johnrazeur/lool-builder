TARGETS := $(ls build | grep -vE 'build-docker|poco')

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m|sed 's/v7l//'` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

poco: .dapper
	cd dapper/poco && ../../.dapper build 2>&1

lool: .dapper
	cd dapper && ../.dapper -m bind -f online/Dockerfile.dapper build 2>&1

libreoffice: .dapper
	cd dapper/core && ../../.dapper build 2>&1

release:
	docker build -t gollool:latest dapper/

.PHONY: $(TARGETS) config