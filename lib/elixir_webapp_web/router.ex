defmodule ElixirWebappWeb.Router do
  use ElixirWebappWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :browser_safe do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :static do
    plug Plug.Static,
      at: "/",
      from: {:elixir_webapp, "priv/static"}
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser_safe
      live_dashboard "/dashboard", metrics: ElixirWebappWeb.Telemetry
    end
  end

  scope "/api/v1", ElixirWebappWeb do
    get "/version", APIController, :version
  end

  scope "/", ElixirWebappWeb do
    pipe_through [:browser]

    get "/", PageController, :index

    scope "/" do
      pipe_through :static
      get "/*path", PageController, :file_not_found
    end
  end
end
