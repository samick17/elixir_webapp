defmodule ElixirWebapp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ElixirWebappWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ElixirWebapp.PubSub},
      # Start the Endpoint (http/https)
      ElixirWebappWeb.Endpoint
      # Start a worker by calling: ElixirWebapp.Worker.start_link(arg)
      # {ElixirWebapp.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirWebapp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirWebappWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
