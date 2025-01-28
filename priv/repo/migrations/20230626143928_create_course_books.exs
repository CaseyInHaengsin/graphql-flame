defmodule HogwartsApi.Repo.Migrations.CreateCourseBooks do
  use Ecto.Migration

  def change do
    create table(:course_books, primary_key: false) do
      add :course_id, references(:courses, on_delete: :nothing, type: :binary_id),
        null: false,
        primary_key: true

      add :book_id, references(:books, on_delete: :nothing, type: :binary_id),
        null: false,
        primary_key: true

      timestamps()
    end

    create index(:course_books, [:course_id])
    create index(:course_books, [:book_id])
  end
end
