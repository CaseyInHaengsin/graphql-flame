defmodule HogwartsApi.Repo.Migrations.CreateRooms do
  use Ecto.Migration

  def change do
    create table(:rooms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :number, :string, null: false
      add :haunted, :boolean, default: false, null: false
      add :cursed, :boolean, default: false, null: false
      add :hexed, :boolean, default: false, null: false
      add :secret_passage, :boolean, default: false, null: false
      add :static, :boolean, default: false, null: false

      timestamps()
    end
  end
end
