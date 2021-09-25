defmodule ElixirWebappWeb.APIController do
  use ElixirWebappWeb, :controller

	@version Mix.Project.config()[:version]

	# Begin of API Endpoints
	def version(conn, _params) do
		json(conn, %{
      version: @version
    })
	end
	# End of API Endpoints


end
