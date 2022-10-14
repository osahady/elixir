defmodule HelloWeb.PageController do
  use HelloWeb, :controller
  alias Plug.Conn

  def redirect_test(conn, _params) do
    render(conn, "index.html")
  end
  
  def index(conn, _params) do
    conn
    |> put_flash(:info, "سبحان الله والحمد لله ولا إله إلا الله والله أكبر")
    |> put_flash(:error, "من حلف بغير الله فقد كفر أو أشرك")
    |> redirect(to: Routes.page_path(conn, :redirect_test))
    # redirect(conn, to: Routes.page_path(conn, :redirect_test))

    # redirect(conn, external: "https://aljazeera.net")

    # send_resp(conn, 201, "")
    # render(conn, :index)
    # conn
    # |> put_root_layout("admin.html")
    # |> render("index.html")

    # conn
    # |> put_resp_content_type("text/xml")
    # |> render("index.xml", content: some_xml_content)

    # conn
    # |> put_status(202)
    # |> render("index.html")

  end
end
