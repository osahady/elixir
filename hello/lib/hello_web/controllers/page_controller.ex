defmodule HelloWeb.PageController do
  use HelloWeb, :controller
  alias Plug.Conn

  def index(conn, _params) do
    # send_resp(conn, 201, "")
    # render(conn, :index)
    # conn
    # |> put_root_layout("admin.html")
    # |> render("index.html")

    # conn
    # |> put_resp_content_type("text/xml")
    # |> render("index.xml", content: some_xml_content)

    conn
    |> put_status(202)
    |> render("index.html")
  end
end
