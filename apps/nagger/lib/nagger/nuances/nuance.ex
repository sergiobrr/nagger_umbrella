defmodule Nagger.Nuances.Nuance do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nagger.Tags.Tag

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "nuances" do
    field :name, :string
    field :slug, :string
    many_to_many :tags, Tag, join_through: "nuance_tags"

    timestamps()
  end

  @doc """
  Describe valid changeset for nuance instances with unique constraint
  and format validation on the slug field
"""
  def changeset(nuance, attrs) do
    nuance
    |> cast(attrs, [:name, :slug])
    |> validate_required([:name, :slug])
    |> unique_constraint(:slug)
    |> validate_format(:slug, ~r/^[a-z0-9-_]+$/)
  end
end
