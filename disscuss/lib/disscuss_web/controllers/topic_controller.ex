defmodule DisscussWeb.TopicController do
  use DisscussWeb, :controller
  alias Disscuss.Topic
  alias Disscuss.Repo


  def index(conn, _p) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => params}) do
    IO.puts "*******ffffffffffff*****"
    changeset = Topic.changeset(%Topic{}, params)
    case Repo.insert(changeset) do
      {:ok, topic} -> 
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: Routes.topic_path(conn, :show, topic.id))
      {:error, changeset} -> 
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)
    changeset = Topic.changeset(topic)
    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def update(conn, %{"id" => id, "topic" => params}) do
    changeset = Repo.get!(Topic, id) |> Topic.changeset(params)

    case Repo.update(changeset) do
      {:ok, _topic} -> 
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: Routes.topic_path(conn, :show, id))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: Repo.get(Topic, id))
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Repo.get!(Topic, id)
    render(conn, "show.html", topic: topic)
  end

  def delete(conn, %{"id" => id}) do
    Repo.get!(Topic, id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic deleted")
    |> redirect(to: Routes.topic_path(conn, :index))
  end
end
