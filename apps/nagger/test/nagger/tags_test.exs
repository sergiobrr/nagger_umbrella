defmodule Nagger.TagsTest do
  use Nagger.DataCase

  alias Nagger.Tags

  describe "tags" do
    alias Nagger.Tags.Tag
    alias Nagger.Nuances

    @valid_attrs %{value: "some value"}
    @update_attrs %{value: "some updated value"}
    @invalid_attrs %{value: nil}
    @valid_attrs_nuance %{name: "some name", slug: "some-slug"}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tags.create_tag()

      tag
    end

    def nuance_fixture(attrs \\ %{}) do
      {:ok, nuance} =
        attrs
        |> Enum.into(@valid_attrs_nuance)
        |> Nuances.create_nuance()

      nuance.id
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Tags.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Tags.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Tags.create_tag(@valid_attrs)
      assert tag.value == "some value"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tags.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Tags.update_tag(tag, @update_attrs)
      assert tag.value == "some updated value"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Tags.update_tag(tag, @invalid_attrs)
      assert tag == Tags.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Tags.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Tags.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Tags.change_tag(tag)
    end

    test "create_tag_with_reference/2 create appropriate relationship too" do
      nuance_id = nuance_fixture()
      {:ok, nuance_tag} = Tags.create_tag_with_reference(@valid_attrs, nuance_id)
      assert nuance_tag.nuance_id == nuance_id
    end
  end
end
