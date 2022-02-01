test:
	bin/rails test
lint:
	bundle exec rubocop
	slim-lint app/views/
install:
	yarn install
	bundle install
	bin/rails webpacker:compile
migrate:
	bin/rails db:migrate
seed:
	bin/rails db:seed
start:
	bin/rails s
.PHONY: test