#!/usr/bin/env sh

TAG=elixir_webapp
SECRET_KEY_BASE=$(mix phx.gen.secret)
VERSION=latest

docker build \
--build-arg SECRET_KEY_BASE=${SECRET_KEY_BASE} \
-f ./docker/Dockerfile \
-t ${TAG}:${VERSION} \
.
