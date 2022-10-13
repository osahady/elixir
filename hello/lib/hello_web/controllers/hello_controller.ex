defmodule HelloWeb.HelloController do
  use HelloWeb, :controller
  alias Plug.Conn

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def show(conn, %{"person" => val}) do
    # text(conn, "from controller #{val}")
    # json(conn, %{name: val})
    # render(conn, "show.html", variable: val)
     conn
    |> assign(:variable, val)
    |> assign(:variable2, "THERE IS NO GOD BUT ALLAH")
    |> render("show.html")
  end
end