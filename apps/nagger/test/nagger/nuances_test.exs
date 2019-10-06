defmodule Nagger.NuancesTest do
  use Nagger.DataCase

  alias Nagger.Nuances

  describe "nuances" do
    alias Nagger.Nuances.Nuance

    @valid_attrs %{name: "some name", slug: "some-slug"}
    @update_attrs %{name: "some updated name", slug: "some-updated-slug"}
    @invalid_attrs %{name: nil, slug: nil}

    def nuance_fixture(attrs \\ %{}) do
      {:ok, nuance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Nuances.create_nuance()

      nuance
    end

    test "list_nuances/0 returns all nuances" do
      nuance = nuance_fixture()
      assert Nuances.list_nuances() == [nuance]
    end

    test "get_nuance!/1 returns the nuance with given id" do
      nuance = nuance_fixture()
      assert Nuances.get_nuance!(nuance.id) == nuance
    end

    test "create_nuance/1 with valid data creates a nuance" do
      assert {:ok, %Nuance{} = nuance} = Nuances.create_nuance(@valid_attrs)
      assert nuance.name == "some name"
      assert nuance.slug == "some-slug"
    end

    test "create_nuance/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Nuances.create_nuance(@invalid_attrs)
    end

    test "update_nuance/2 with valid data updates the nuance" do
      nuance = nuance_fixture()
      assert {:ok, %Nuance{} = nuance} = Nuances.update_nuance(nuance, @update_attrs)
      assert nuance.name == "some updated name"
      assert nuance.slug == "some-updated-slug"
    end

    test "update_nuance/2 with invalid data returns error changeset" do
      nuance = nuance_fixture()
      assert {:error, %Ecto.Changeset{}} = Nuances.update_nuance(nuance, @invalid_attrs)
      assert nuance == Nuances.get_nuance!(nuance.id)
    end

    test "delete_nuance/1 deletes the nuance" do
      nuance = nuance_fixture()
      assert {:ok, %Nuance{}} = Nuances.delete_nuance(nuance)
      assert_raise Ecto.NoResultsError, fn -> Nuances.get_nuance!(nuance.id) end
    end

    test "change_nuance/1 returns a nuance changeset" do
      nuance = nuance_fixture()
      assert %Ecto.Changeset{} = Nuances.change_nuance(nuance)
    end
  end
end
