defmodule Nagger.Nuances do
  @moduledoc """
  The Nuances context.
  """

  import Ecto.Query, warn: false
  alias Nagger.Repo

  alias Nagger.Nuances.Nuance

  @doc """
  Returns the list of nuances.

  ## Examples

      iex> list_nuances()
      [%Nuance{}, ...]

  """
  def list_nuances do
    Repo.all(Nuance) |> Repo.preload([:tags])
  end

  @doc """
  Gets a single nuance.

  Raises `Ecto.NoResultsError` if the Nuance does not exist.

  ## Examples

      iex> get_nuance!(123)
      %Nuance{}

      iex> get_nuance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nuance!(id), do: Repo.get!(Nuance, id) |> Repo.preload([:tags])

  @doc """
  Creates a nuance.

  ## Examples

      iex> create_nuance(%{field: value})
      {:ok, %Nuance{}}

      iex> create_nuance(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nuance(attrs \\ %{}) do
    %Nuance{}
    |> Nuance.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nuance.

  ## Examples

      iex> update_nuance(nuance, %{field: new_value})
      {:ok, %Nuance{}}

      iex> update_nuance(nuance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nuance(%Nuance{} = nuance, attrs) do
    nuance
    |> Nuance.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Nuance.

  ## Examples

      iex> delete_nuance(nuance)
      {:ok, %Nuance{}}

      iex> delete_nuance(nuance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nuance(%Nuance{} = nuance) do
    Repo.delete(nuance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nuance changes.

  ## Examples

      iex> change_nuance(nuance)
      %Ecto.Changeset{source: %Nuance{}}

  """
  def change_nuance(%Nuance{} = nuance) do
    Nuance.changeset(nuance, %{})
  end
end
