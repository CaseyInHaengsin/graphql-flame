defmodule HogwartsApi.Beings.Professor do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "professors" do
    field :house, Ecto.Enum, values: [:gryffindor, :slytherin, :ravenclaw, :hufflepuff]
    field :is_animagus, :boolean, default: false
    field :is_deatheater, :boolean, default: false
    has_many :sections, HogwartsApi.Scheduling.Section
    # has_many :sections, HogwartsApi.Scheduling.Section
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(professor, attrs) do
    professor
    |> cast(attrs, [:name, :house, :is_animagus, :is_deatheater])
    |> cast_assoc(:sections, required: false)
    |> validate_required([:name, :house, :is_animagus, :is_deatheater])
  end
end
