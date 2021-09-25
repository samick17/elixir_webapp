import Config

secret_key_base = System.get_env("SECRET_KEY_BASE")
host = System.get_env("HOST") || "0.0.0.0"
port = System.get_env("PORT") || 8000

config :elixir_webapp, ElixirWebappWeb.Endpoint,
  url: [host: host, port: port],
  server: true,
  http: [
    port: port,
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :elixir_webapp, :host_domain_name, System.get_env("DOMAIN_NAME") || "http://localhost:4200"

config :elixir_webapp, :cors_options,
  origin: String.split(System.get_env("CHECK_ORIGIN", ""), ",")
