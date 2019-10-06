defmodule Nagger.Repo.Migrations.CreateNuanceTags do
  use Ecto.Migration

  def change do
    create table(:nuance_tags, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :nuance_id, references(:nuances, on_replace: :update, on_delete: :nothing, type: :binary_id)
      add :tag_id, references(:tags, on_replace: :update, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:nuance_tags, [:nuance_id])
    create index(:nuance_tags, [:tag_id])
    create unique_index(:nuance_tags, [:nuance_id, :tag_id])
  end
end
