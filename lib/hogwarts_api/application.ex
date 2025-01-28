defmodule HogwartsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    flame_parent = FLAME.Parent.get()

    children =
      [
        # Start the Telemetry supervisor
        HogwartsApiWeb.Telemetry,
        # Start the Ecto repository
        HogwartsApi.Repo,
        # Start the PubSub system
        {Phoenix.PubSub, name: HogwartsApi.PubSub},
        # Start the Endpoint (http/https)
        !flame_parent && HogwartsApiWeb.Endpoint,
        {FLAME.Pool,
         name: HogwartsApi.Flamethrower,
         min: 1,
         max: 10,
         max_concurrency: 5,
         idle_shutdown_after: 30_000,
         log: :debug},
        {Absinthe.Subscription, HogwartsApiWeb.Endpoint},
        {Oban, Application.fetch_env!(:hogwarts_api, Oban)}
        # Start a worker by calling: HogwartsApi.Worker.start_link(arg)
        # {HogwartsApi.Worker, arg}
      ]
      |> Enum.filter(& &1)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HogwartsApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HogwartsApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
