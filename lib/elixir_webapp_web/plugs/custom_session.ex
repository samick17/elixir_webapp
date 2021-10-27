defmodule ElixirWebappWeb.Plugs.CustomSession do

  def init(opts) do
    opts = Keyword.merge(opts, Application.get_env(:elixir_webapp, :session))
    Plug.Session.init(opts)
  end

  def call(conn, opts) do
    domain = case System.get_env("COOKIE_DOMAIN", "") do
      "" ->
        headers_map = Map.get(conn, :req_headers) |> Map.new
        referer = Map.get(headers_map, "referer")
        uri = URI.parse(referer)
        Map.get(uri, :host)
      value -> value
    end
    same_site = case System.get_env("COOKIE_SAME_SITE", "") do
      "" -> "Strict"
      value -> value
    end
    cookie_opts = Map.get(opts, :cookie_opts)
    cookie_opts = Keyword.put(cookie_opts, :domain, domain)
    cookie_opts = Keyword.put(cookie_opts, :same_site, same_site)
    runtime_opts = Map.put(opts, :cookie_opts, cookie_opts)
    Plug.Session.call(conn, runtime_opts)
  end
end
