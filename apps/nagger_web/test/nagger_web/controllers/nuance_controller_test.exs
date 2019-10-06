defmodule NaggerWeb.NuanceControllerTest do
  use NaggerWeb.ConnCase

  alias Nagger.Nuances

  @create_attrs %{name: "some name", slug: "some slug"}
  @update_attrs %{name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{name: nil, slug: nil}

  def fixture(:nuance) do
    {:ok, nuance} = Nuances.create_nuance(@create_attrs)
    nuance
  end

  describe "index" do
    test "lists all nuances", %{conn: conn} do
      conn = get(conn, Routes.nuance_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Nuances"
    end
  end

  describe "new nuance" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.nuance_path(conn, :new))
      assert html_response(conn, 200) =~ "New Nuance"
    end
  end

  describe "create nuance" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.nuance_path(conn, :create), nuance: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.nuance_path(conn, :show, id)

      conn = get(conn, Routes.nuance_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Nuance"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.nuance_path(conn, :create), nuance: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Nuance"
    end
  end

  describe "edit nuance" do
    setup [:create_nuance]

    test "renders form for editing chosen nuance", %{conn: conn, nuance: nuance} do
      conn = get(conn, Routes.nuance_path(conn, :edit, nuance))
      assert html_response(conn, 200) =~ "Edit Nuance"
    end
  end

  describe "update nuance" do
    setup [:create_nuance]

    test "redirects when data is valid", %{conn: conn, nuance: nuance} do
      conn = put(conn, Routes.nuance_path(conn, :update, nuance), nuance: @update_attrs)
      assert redirected_to(conn) == Routes.nuance_path(conn, :show, nuance)

      conn = get(conn, Routes.nuance_path(conn, :show, nuance))
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, nuance: nuance} do
      conn = put(conn, Routes.nuance_path(conn, :update, nuance), nuance: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Nuance"
    end
  end

  describe "delete nuance" do
    setup [:create_nuance]

    test "deletes chosen nuance", %{conn: conn, nuance: nuance} do
      conn = delete(conn, Routes.nuance_path(conn, :delete, nuance))
      assert redirected_to(conn) == Routes.nuance_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.nuance_path(conn, :show, nuance))
      end
    end
  end

  defp create_nuance(_) do
    nuance = fixture(:nuance)
    {:ok, nuance: nuance}
  end
end
