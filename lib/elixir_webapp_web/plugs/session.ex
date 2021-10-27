defmodule ElixirWebappWeb.Plugs.Session do
  use ElixirWebappWeb, :controller

  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn = conn
    |> fetch_session
    |> fetch_flash
    session = conn
    |> get_session(:session)
    case session do
      true ->
        conn
      _ ->
        conn
        |> put_status(401)
        |> json(%{message: "Invalid credentials"})
        |> halt()
    end
  end
end
