defmodule HogwartsApi.Scheduling.StudentSection do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  @foreign_key_type :binary_id
  schema "student_sections" do
    belongs_to :student, HogwartsApi.Beings.Student
    belongs_to :section, HogwartsApi.Scheduling.Section
    # field :student_id, :binary_id
    # field :section_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(student_section, attrs) do
    student_section
    |> cast(attrs, [])
    |> cast_assoc(:student, required: true)
    |> validate_required([:student_id, :section_id])
  end
end
