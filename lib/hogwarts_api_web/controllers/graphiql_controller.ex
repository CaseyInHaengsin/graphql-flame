defmodule HogwartsApiWeb.GraphiqlController do
  use HogwartsApiWeb, :controller

  def index(conn, _params) do
    token = conn |> Map.get(:cookies) |> Map.get("token")

    conn
    |> put_root_layout(false)
    |> put_layout(false)
    |> render(:index,
      config: %{
        "endpoint" => "/graphql",
        "subscriptionEndpoint" => "/graphql/websocket",
        "canSaveConfig" => false,
        "headers" => %{"Authorization" => "Bearer #{token}"}
      }
    )
  end
end
