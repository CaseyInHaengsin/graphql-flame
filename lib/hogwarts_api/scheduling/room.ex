defmodule HogwartsApi.Scheduling.Room do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rooms" do
    field :cursed, :boolean, default: false
    field :haunted, :boolean, default: false
    field :hexed, :boolean, default: false
    field :number, :string
    field :secret_passage, :boolean, default: false
    field :static, :boolean, default: false
    has_many :sections, HogwartsApi.Scheduling.Section

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:number, :haunted, :cursed, :hexed, :secret_passage, :static])
    |> cast_assoc(:sections, required: false)
    |> validate_required([:number, :haunted, :cursed, :hexed, :secret_passage, :static])
  end
end
