defmodule NaggerWeb.TagController do
  use NaggerWeb, :controller

  import Ecto.Query

  alias Nagger.Tags
  alias Nagger.Tags.Tag
  alias NaggerWeb.FilterConfig

  action_fallback NaggerWeb.FallbackController

  def index(conn, params \\ nil) do
    if params do
      query = get_query(params)
      tags = Tags.list_tags(query)
      render(conn, "index.json", tags: tags)
    else
      tags = Tags.list_tags()
      render(conn, "index.json", tags: tags)
    end
  end

  def get_query(params) do
    {:ok, filter} = FilterConfig.tags()
      |> Filtrex.parse_params(params)
    Filtrex.query(from(t in Tag), filter)
  end

  def create(conn, %{"tag" => tag_params, "nuance_id" => nuance_id}) do
    with {:ok, %Tag{} = tag} <- Tags.create_tag_with_reference(
      tag_params, nuance_id
    ) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.tag_path(conn, :show, tag))
      |> render("show.json", tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)
    render(conn, "show.json", tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Tags.update_tag(tag, tag_params) do
      render(conn, "show.json", tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Tags.get_tag!(id)

    with {:ok, %Tag{}} <- Tags.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
