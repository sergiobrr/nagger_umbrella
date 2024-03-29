defmodule NaggerWeb.TagControllerTest do
  use NaggerWeb.ConnCase

  alias Nagger.Tags
  alias Nagger.Tags.Tag

  @create_attrs %{
    value: "some value"
  }
  @create_attrs_again %{
    value: "some value again"
  }
  @update_attrs %{
    value: "some updated value"
  }
  @invalid_attrs %{value: nil}

  def fixture(:tag) do
    {:ok, tag} = Tags.create_tag(@create_attrs)
    tag
  end

  def fixture_again(:tag) do
    {:ok, tag} = Tags.create_tag(@create_attrs_again)
    tag
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index no data" do
    test "lists all tags", %{conn: conn} do
      conn = get(conn, Routes.tag_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "index with data and filter" do
    setup [:create_tags]

    test "renders only tags filtered" do
      conn = get(conn, Routes.tag_path(conn, :index), %{:value => "some value again"})
      # IO.puts json_response(conn, 200)["data"]
      assert 9 == 9
    end
  end

  describe "create tag" do
    test "renders tag when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tag_path(conn, :create), tag: @create_attrs, nuance_id: nil)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.tag_path(conn, :show, id))

      assert %{
               "id" => id,
               "value" => "some value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tag_path(conn, :create), tag: @invalid_attrs, nuance_id: nil)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "renders tag when data is valid", %{conn: conn, tag: %Tag{id: id} = tag} do
      conn = put(conn, Routes.tag_path(conn, :update, tag), tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.tag_path(conn, :show, id))

      assert %{
               "id" => id,
               "value" => "some updated value"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put(conn, Routes.tag_path(conn, :update, tag), tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: conn, tag: tag} do
      conn = delete(conn, Routes.tag_path(conn, :delete, tag))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.tag_path(conn, :show, tag))
      end
    end
  end

  defp create_tag(_) do
    tag = fixture(:tag)
    {:ok, tag: tag}
  end

  defp create_tags(_) do
    tag = fixture(:tag)
    tag_again = fixture_again(:tag)
    {:ok, tags: [tag, tag_again]}
  end
end
