defmodule HogwartsApi.Repo do
  use Ecto.Repo,
    otp_app: :hogwarts_api,
    adapter: Ecto.Adapters.Postgres
end
