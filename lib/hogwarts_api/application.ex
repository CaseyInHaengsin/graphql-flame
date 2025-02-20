defmodule HogwartsApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    flame_parent = FLAME.Parent.get()
    topologies = Application.get_env(:libcluster, :topologies) || []

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
        !flame_parent &&
          {Cluster.Supervisor, [topologies, [name: HogwartsApi.ClusterSupervisor]]},
        {FLAME.Pool,
         name: HogwartsApi.Flamethrower,
         min: 1,
         max: 10,
         max_concurrency: 5,
         idle_shutdown_after: 30_000,
         log: :debug},
        {ChromicPDF,
         [
           no_sandbox: true,
           on_demand: true,
           session_pool: [
             timeout: 10_000,
             checkout_timeout: 60_000,
             size: 75,
             max_uses: 10,
             init_timeout: 20_000
           ],
           offline: false,
           discard_stderr: false,
           ignore_certificate_errors: true,
           disable_scripts: false,
           chrome_args: [
             "--no-sandbox",
             "--disable-setuid-sandbox",
             "--ignore-ssl-errors",
             "--ignore-certificate-errors",
             "--ignore-certificate-errors-spki-list",
             "--disable-gpu",
             "--log-level=2"
           ]
         ]},
        !flame_parent && {Absinthe.Subscription, HogwartsApiWeb.Endpoint},
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
