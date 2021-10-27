defmodule ElixirWebappWeb.PageController do
  use ElixirWebappWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
    |> halt()
  end

  def page_not_found(conn, _params) do
    conn
    |> render("page_not_found.html")
    |> halt()
  end

  def serve_index(conn, _params) do
    conn
    |> redirect(to: "/index.html")
  end
end
