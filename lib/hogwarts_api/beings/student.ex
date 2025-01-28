defmodule HogwartsApi.Beings.Student do
  use Ecto.Schema
  import Ecto.Changeset
  alias HogwartsApi.Scheduling.{StudentSection, Section}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "students" do
    field :house, Ecto.Enum, values: [:gryffindor, :slytherin, :ravenclaw, :hufflepuff]
    field :name, :string
    field :plot_armor, :boolean, default: false
    has_many :student_sections, HogwartsApi.Scheduling.StudentSection
    many_to_many :sections, Section, join_through: StudentSection

    timestamps()
  end

  @doc false
  def changeset(student, attrs) do
    student
    |> cast(attrs, [:name, :house, :plot_armor])
    |> validate_required([:name, :house, :plot_armor])
  end
end
