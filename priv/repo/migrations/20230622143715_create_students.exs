defmodule HogwartsApi.Repo.Migrations.CreateStudents do
  use Ecto.Migration

  def change do
    create table(:students, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :house, :string, null: false
      add :plot_armor, :boolean, default: false, null: false

      timestamps()
    end
  end
end
