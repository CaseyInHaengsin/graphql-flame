# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :hogwarts_api,
  ecto_repos: [HogwartsApi.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :hogwarts_api, HogwartsApiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: HogwartsApiWeb.ErrorHTML, json: HogwartsApiWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: HogwartsApi.PubSub,
  live_view: [signing_salt: "vuMrN5TP"]

config :hogwarts_api, Oban,
  repo: HogwartsApi.Repo,
  engine: Oban.Engines.Lite,
  queues: [default: 10, mailer: 10, pdf_generation: 10]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
