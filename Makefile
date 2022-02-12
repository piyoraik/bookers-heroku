docker.build:
	@docker compose build --no-cache

docker.up:
	@docker compose up -d

bundle.install:
	@docker compose run --rm --no-deps web bundle install

webpacker.install:
	@docker compose run --rm --no-deps web rails webpacker:install