defmodule ElixirWebappWeb.PageController do
  use ElixirWebappWeb, :controller

  def index(conn, params) do
    IO.inspect(params)
    conn
    |> render("index.html")
    |> halt()
  end

  def file_not_found(conn, params) do
    conn
    |> render("page_not_found.html")
    |> halt()
  end
end
