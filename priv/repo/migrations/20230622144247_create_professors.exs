defmodule HogwartsApi.Repo.Migrations.CreateProfessors do
  use Ecto.Migration

  def change do
    create table(:professors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :house, :string, null: false
      add :is_animagus, :boolean, default: false, null: false
      add :is_deatheater, :boolean, default: false, null: false

      timestamps()
    end
  end
end
