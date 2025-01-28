defmodule HogwartsApi.Repo.Migrations.CreateSections do
  use Ecto.Migration

  def change do
    create table(:sections, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :time, :string
      add :semester, :string
      add :course_id, references(:courses, on_delete: :nothing, type: :binary_id), null: false
      add :professor_id, references(:professors, on_delete: :nilify_all, type: :binary_id)
      add :room_id, references(:rooms, on_delete: :nilify_all, type: :binary_id)

      timestamps()
    end

    create index(:sections, [:course_id])
    create index(:sections, [:professor_id])
    create index(:sections, [:room_id])
  end
end
