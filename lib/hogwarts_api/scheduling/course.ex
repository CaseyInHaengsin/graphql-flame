defmodule HogwartsApi.Scheduling.Course do
  use Ecto.Schema
  import Ecto.Changeset
  alias HogwartsApi.Scheduling.{CourseBook, Book}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "courses" do
    field :name, :string
    many_to_many :books, Book, join_through: CourseBook
    has_many :sections, HogwartsApi.Scheduling.Section

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name])
    |> cast_assoc(:sections, required: false)
    |> validate_required([:name])
  end
end
