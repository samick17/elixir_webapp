defmodule ElixirWebappWeb.Cors do

  def get_cors_origins() do
    Application.get_env(:elixir_webapp, :cors_options)[:origin]
  end

end
