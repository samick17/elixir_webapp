MAKEFLAGS += --silent
ENVFILE:=$(shell cat .env)

SECRET_KEY_BASE=PkSJ/8W63lQ/YYjJitOv4n1SrCpJqlhlFtzUm3vEz23AzeQhcLFM6RdP43L8AjeC
NAME=elixir_webapp
HEROKU_APP_NAME=swin-elixir-webapp
IMAGE_NAME=elixir_webapp
VERSION=latest

init:
	mix deps.get

clean:
	rm -rf ./_build

build-docker:
	env $(ENVFILE) docker build . --tag ${IMAGE_NAME}:${VERSION}

launch:
	env $(ENVFILE) iex -S mix phx.server

launch-docker:
	docker run -p 8000:8000 --name ${NAME} -d ${IMAGE_NAME}:${VERSION}

heroku-login:
	heroku container:login

heroku-push:
	env $(ENVFILE) heroku container:push web -a ${HEROKU_APP_NAME}

heroku-release:
	heroku container:release web -a ${HEROKU_APP_NAME}

heroku-logs:
	heroku logs --tail --app ${HEROKU_APP_NAME}

all:
	make clean
	make build-docker
	make launch-docker

update-frontend-view:
	rm -rf ./priv/static
	cd frontend && npm run build:prod && mv ./build ../priv/static

init-submodules:
	git submodule update --init --recursive

update-submodules:
	git submodule foreach --recursive git pull origin master

