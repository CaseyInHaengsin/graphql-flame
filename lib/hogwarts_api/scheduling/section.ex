defmodule HogwartsApi.Scheduling.Section do
  use Ecto.Schema
  import Ecto.Changeset
  alias HogwartsApi.Scheduling.{StudentSection, Course, Room}
  alias HogwartsApi.Beings.{Student, Professor}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sections" do
    field :semester, :string
    field :time, :string
    belongs_to :professor, Professor
    belongs_to :course, Course
    belongs_to :room, Room
    many_to_many :students, Student, join_through: StudentSection

    # field :professor_id, :binary_id
    # field :room_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(section, attrs) do
    section
    |> cast(attrs, [:time, :semester])
    |> cast_assoc(:course, required: true)
    |> cast_assoc(:room, required: true)
    |> cast_assoc(:professor, required: false)
    |> validate_required([:time, :semester, :course_id])
  end
end
