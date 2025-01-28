defmodule HogwartsApiWeb.Router do
  alias HogwartsApiWeb.GraphiqlController
  use HogwartsApiWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    # plug :fetch_live_flash
    # plug :put_root_layout, html: {HogwartsApiWeb.Layouts, :root}
    # plug :protect_from_forgery
    # plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/ui" do
    pipe_through :browser
  end

  scope "/" do
    pipe_through :api

    forward "/graphql", Absinthe.Plug,
      schema: HogwartsApiWeb.Schema,
      before_send: {__MODULE__, :absinthe_before_send},
      analyze_complexity: true
  end

  scope "/" do
    pipe_through :browser
    get "/", GraphiqlController, :index
  end

  # scope "/" do
  #   # pipe_through :browser

  #   # socket: HogwartsApiWeb.AbsintheSocket,
  #   # socket_url: "/api/graphql"

  #   # forward "/", Absinthe.Plug.GraphiQL,
  #   #   schema: HogwartsApiWeb.Schema,
  #   #   interface: :playground,
  #   #   default_url: "/graphql",
  #   #   socket_url: "/api/graphql",
  #   #   socket: HogwartsApiWeb.AbsintheSocket
  # end

  def absinthe_before_send(conn, %Absinthe.Blueprint{} = blueprint) do
    complexity =
      Enum.filter(blueprint.operations, fn operation -> operation.complexity != nil end)
      |> Enum.map(fn operation -> operation.complexity end)
      |> Enum.sum()
      |> Integer.to_string()

    conn
    |> put_resp_header(
      "X-GraphQL-Complexity",
      complexity
    )
  end

  def absinthe_before_send(conn, _), do: conn

  # Enable LiveDashboard in development
  if Application.compile_env(:hogwarts_api, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: HogwartsApiWeb.Telemetry
    end
  end
end
