defmodule NaggerWeb.PageController do
  use NaggerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
