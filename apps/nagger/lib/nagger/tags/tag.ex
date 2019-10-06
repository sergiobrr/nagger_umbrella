defmodule Nagger.Tags.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nagger.Nuances.Nuance

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tags" do
    field :value, :string
    many_to_many :nuances, Nuance, join_through: "nuance_tags"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:value])
    |> validate_required([:value])
    |> unique_constraint(:value)
  end
end
