defmodule NaggerWeb.NuanceController do
  use NaggerWeb, :controller

  alias Nagger.Nuances
  alias Nagger.Nuances.Nuance

  def index(conn, _params) do
    nuances = Nuances.list_nuances()
    render(conn, "index.html", nuances: nuances)
  end

  def new(conn, _params) do
    changeset = Nuances.change_nuance(%Nuance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"nuance" => nuance_params}) do
    case Nuances.create_nuance(nuance_params) do
      {:ok, nuance} ->
        conn
        |> put_flash(:info, "Nuance created successfully.")
        |> redirect(to: Routes.nuance_path(conn, :show, nuance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    nuance = Nuances.get_nuance!(id)
    render(conn, "show.html", nuance: nuance)
  end

  def edit(conn, %{"id" => id}) do
    nuance = Nuances.get_nuance!(id)
    changeset = Nuances.change_nuance(nuance)
    render(conn, "edit.html", nuance: nuance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "nuance" => nuance_params}) do
    nuance = Nuances.get_nuance!(id)

    case Nuances.update_nuance(nuance, nuance_params) do
      {:ok, nuance} ->
        conn
        |> put_flash(:info, "Nuance updated successfully.")
        |> redirect(to: Routes.nuance_path(conn, :show, nuance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", nuance: nuance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    nuance = Nuances.get_nuance!(id)
    {:ok, _nuance} = Nuances.delete_nuance(nuance)

    conn
    |> put_flash(:info, "Nuance deleted successfully.")
    |> redirect(to: Routes.nuance_path(conn, :index))
  end
end
