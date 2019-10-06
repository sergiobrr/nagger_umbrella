defmodule Nagger.Nuances.NuanceTag do
  use Ecto.Schema
  import Ecto.Changeset

  alias Nagger.Nuances.Nuance
  alias Nagger.Tags.Tag

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "nuance_tags" do
    belongs_to :nuance, Nuance
    belongs_to :tag, Tag

    timestamps()
  end

  @doc false
  def changeset(nuance_tag, attrs) do
    nuance_tag
    |> cast(attrs, [:nuance_id, :tag_id])
    |> validate_required([:nuance_id, :tag_id])
  end
end
