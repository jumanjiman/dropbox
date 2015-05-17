# vim: set ts=8 sw=8 ai noet:
.PHONY: all
all: build

clean: stop
	@docker rmi -f jumanjiman/dropbox || :

.PHONY: build
build: clean
	@docker build -t jumanjiman/dropbox:latest src/

.PHONY: stop
stop:
	@rm -f foo || :
	@docker rm -f dropbox || :

.PHONY: start
start:
	@docker run -d --name dropbox -p 21:21 jumanjiman/dropbox:latest

.PHONY: test
test: stop start
	@./test.sh
