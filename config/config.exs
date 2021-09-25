# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

origin = String.split(
      System.get_env("CHECK_ORIGIN", "http://localhost:4200"),
      ","
    )

# Configures the endpoint
config :elixir_webapp, ElixirWebappWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pq8pnrQ+WSqZN4pBs2E9KHx6H42bWO5wOPGyCT44BvEMUiDNvI2xjrKc/HKEAqhl",
  render_errors: [view: ElixirWebappWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirWebapp.PubSub,
  live_view: [signing_salt: "2IiDJr4H"]

config :elixir_webapp, :cors_options,
  origin: origin

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
