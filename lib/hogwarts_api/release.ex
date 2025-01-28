defmodule HogwartsApi.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :hogwarts_api

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  def seed do
    load_app()

    for repo <- repos() do
      seed_path = priv_path_for(repo, "repo/seeds.exs")

      if File.exists?(seed_path) do
        IO.puts("Running seed script for #{inspect(repo)}: #{seed_path}")
        Code.eval_file(seed_path)
      else
        IO.puts("Seed script not found for #{inspect(repo)}: #{seed_path}")
      end
    end
  end

  defp priv_path_for(repo, filename) do
    app = Keyword.fetch!(repo.config(), :otp_app)
    Path.join([:code.priv_dir(app), filename])
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
