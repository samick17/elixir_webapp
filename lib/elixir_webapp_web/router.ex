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

  pipeline :auth do
    plug ElixirWebappWeb.Plugs.Session
  end

  pipeline :admins_only do
    plug :admin_basic_auth
  end

  pipeline :static do
    plug Plug.Static,
      at: "/",
      from: {:elixir_webapp, "priv/static"}
  end

  defp admin_basic_auth(conn, _opts) do
    username = System.get_env("AUTH_USERNAME", "")
    password = System.get_env("AUTH_PASSWORD", "")
    if username == "" and password == "" do
      redirect(conn, to: "/notfound")
    else
      Plug.BasicAuth.basic_auth(conn, username: username, password: password)
    end
  end

  scope "/api/v1", ElixirWebappWeb do
    get "/version", APIController, :version
  end

  scope "/", ElixirWebappWeb do
    pipe_through [:browser_safe, :admins_only]
    live_dashboard "/dashboard", metrics: Telemetry
  end

  scope "/", ElixirWebappWeb do
    pipe_through [:browser]

    get "/about", PageController, :index

    scope "/" do
      pipe_through :static
      get "/", PageController, :serve_index
      get "/index", PageController, :serve_index
      get "/*path", PageController, :page_not_found
      post "/*path", PageController, :page_not_found
      put "/*path", PageController, :page_not_found
      delete "/*path", PageController, :page_not_found
    end
  end
end
