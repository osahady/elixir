defmodule DisscussWeb.TopicController do
  use DisscussWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end
