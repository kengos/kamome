.DEFAULT_GOAL := test

.PHONY: test
test: rubocop rspec

.PHONY: rubocop
rubocop:
	@bundle exec rubocop

.PHONY: rspec
rspec:
	@bundle exec rspec
