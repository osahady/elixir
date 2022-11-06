defmodule PollerPhxWeb.DistrictController do
  use PollerPhxWeb, :controller
  alias PollerDal.Districts

  def index(conn, _params) do
    districts = Districts.list_districts()
    render(conn, "index.html", districts: districts)
  end

  def new(conn, _params) do
    render(conn, "new.html")
    # Phoenix.Controller.html(conn, "<html>...</html>")
  end
end
