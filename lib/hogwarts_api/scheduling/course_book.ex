defmodule HogwartsApi.Scheduling.CourseBook do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "course_books" do
    belongs_to :course, HogwartsApi.Scheduling.Course
    belongs_to :book, HogwartsApi.Scheduling.Book
    timestamps()
  end

  @doc false
  def changeset(course_book, attrs) do
    course_book
    |> cast(attrs, [])
    |> cast_assoc(:course, required: true)
    |> cast_assoc(:book, required: true)
    |> validate_required([:course_id, :book_id])
  end
end
