RUBY_IMAGE:=$(shell head -n 1 Dockerfile | cut -d ' ' -f 2)
ENVIRONMENT:=tmp/environment
DC:=env RUBY_IMAGE=$(RUBY_IMAGE) docker-compose
GEN_RB:=gen-rb/Example.rb

Gemfile.lock: Gemfile
	$(DC) run --rm bundle

$(GEN_RB): example.thrift
	$(DC) run --rm thrift \
		thrift --gen rb $<

$(ENVIRONMENT): Gemfile.lock
	$(DC) build
	mkdir -p $(@D)
	touch @$

.PHONY: test
test: $(ENVIRONMENT)
	$(DC) run test \
		ruby $(addprefix -r./,$(wildcard test/*_test.rb)) -e 'exit'

.PHONY: test-image
test-image: $(ENVIRONMENT)
	$(DC) run ci \
		ruby $(addprefix -r./,$(wildcard test/*_test.rb)) -e 'exit'

.PHONY: test-smoke
test-smoke: $(ENVIRONMENT)
	$(DC) run --rm ci \
		ruby test/smoke/server_test.rb server:9090

.PHONY:clean
clean:
	$(DC) --kill
	$(DC) rm -v
	rm -rf $(ENVIRONMENT)