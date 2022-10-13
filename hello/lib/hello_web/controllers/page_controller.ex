defmodule HelloWeb.PageController do
  use HelloWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
    # conn
    # |> put_root_layout("admin.html")
    # |> render("index.html")
  end
end
