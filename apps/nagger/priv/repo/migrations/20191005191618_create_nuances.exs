defmodule Nagger.Repo.Migrations.CreateNuances do
  use Ecto.Migration

  def change do
    create table(:nuances, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :slug, :string

      timestamps()
    end

    create unique_index(:nuances, [:slug])
  end
end
