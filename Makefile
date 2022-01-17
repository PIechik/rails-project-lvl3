test:
	bin/rails test
lint:
	bundle exec rubocop
install:
	yarn install
	bundle install
	bin/rails webpacker:compile
migrate:
	bin/rails db:migrate
start:
	bin/rails s
.PHONY: test