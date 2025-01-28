defmodule HogwartsApi.Repo.Migrations.CreateStudentSections do
  use Ecto.Migration

  def change do
    create table(:student_sections, primary_key: false) do
      add :student_id, references(:students, on_delete: :delete_all, type: :binary_id),
        null: false,
        primary_key: true

      add :section_id, references(:sections, on_delete: :delete_all, type: :binary_id),
        null: false,
        primary_key: true

      timestamps()
    end

    create index(:student_sections, [:student_id])
    create index(:student_sections, [:section_id])
  end
end
