defmodule HogwartsApi.Scheduling.Book do
  use Ecto.Schema
  import Ecto.Changeset
  alias HogwartsApi.Scheduling.{Course, CourseBook}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "books" do
    field :author, :string
    field :title, :string
    many_to_many :courses, Course, join_through: CourseBook
    timestamps()
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author])
    |> validate_required([:title, :author])
  end
end
