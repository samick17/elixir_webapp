MAKEFLAGS += --silent

NAME=elixir_webapp

launch:
	iex -S mix phx.server

build-docker:
	./build-docker.sh

launch-docker:
	docker run -p 8000:8000 --name ${NAME} -d elixir_webapp:latest
