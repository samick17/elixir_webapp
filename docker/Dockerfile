# ---- Build Stage - Frontend ----
FROM node:lts-alpine3.12 AS app_builder

RUN mkdir /app
WORKDIR /app
COPY frontend ./

RUN npm i && \
    npm run build

# ---- Build Stage - Server ----
FROM elixir:alpine AS server_builder

# Set environment variables for building the application
ENV MIX_ENV=prod \
    TEST=1 \
    LANG=C.UTF-8

RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY mix.exs mix.lock ./
COPY config ./config
COPY priv ./priv
COPY lib ./lib
COPY --from=app_builder /priv/static ./priv/static

RUN apk add --update git && \
    apk add --virtual build-dependencies && \
    apk add build-base && \
    rm -rf /var/cache/apk/* && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mix deps.compile && \
    SECRET_KEY_BASE=$(mix phx.gen.secret) && \
    mix compile && \
    mix release

# ---- Application Stage ----
FROM alpine:3.12 AS app

ARG SECRET_KEY_BASE=$SECRET_KEY_BASE

ENV LANG=C.UTF-8 \
    SECRET_KEY_BASE=$SECRET_KEY_BASE

RUN mkdir /home/app && \
    # apk add --update ncurses-libs && \
    apk add --no-cache --update openssl ncurses-libs libstdc++ && \
    rm -rf /var/cache/apk/* && \
    echo SECRET:---- $SECRET_KEY_BASE
WORKDIR /home/app

COPY --from=server_builder /app/_build ./_build
COPY entrypoint.sh .

RUN chmod +x ./entrypoint.sh

EXPOSE 8000
# Run the Phoenix app
CMD ["./entrypoint.sh"]
