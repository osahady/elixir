defmodule DisscussWeb.TopicController do
  use DisscussWeb, :controller
  alias Disscuss.Topic

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn,  %{"topic" => topic}) do
    IO.puts "*******ffffffffffff*****"
    IO.inspect(params)
  end
end
