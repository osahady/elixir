defmodule PollerPhxWeb.QuestionController do
  use PollerPhxWeb, :controller
  alias PollerDal.Questions
  alias PollerDal.Questions.Question
  alias PollerDal.Districts

  def index(conn, %{"district_id" => district_id}) do
    district = Districts.get_district!(district_id)
    questions = Questions.list_questions_by_district_id(district_id)
    render(conn, "index.html", district: district, questions: questions)
  end

  def new(conn, %{"district_id" => district_id}) do
    district = Districts.get_district!(district_id)
    changeset = Questions.change_question(%Question{})
    render(conn, "new.html", changeset: changeset, district: district)
  end

  def create(conn, %{"district_id" => district_id, "question" => params}) do
    params = Map.merge(params, %{"district_id" => district_id})

    case Questions.create_question(params) do
      {:ok, _question} ->
        conn
        |> put_flash(:info, "Question Created Successfully")
        |> redirect(to: Routes.question_path(conn, :index, district_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"district_id" => district_id, "id" => id}) do
    district = Districts.get_district!(district_id)
    question = Questions.get_question!(id)
    changeset = Questions.change_question(question)

    render(conn, "edit.html",
      changeset: changeset,
      question: question,
      district: district
    )
  end

  def update(conn, %{"district_id" => district_id, "id" => id, "question" => attrs}) do
    question = Questions.get_question!(id)

    case Questions.update_question(question, attrs) do
      {:ok, _question} ->
        conn
        |> put_flash(:info, "Question updated successfully")
        |> redirect(to: Routes.question_path(conn, :index, district_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset, question: question)
    end
  end

  def delete(conn, %{"district_id" => district_id, "id" => id}) do
    question = Questions.get_question!(id)
    {:ok, _} = Questions.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully")
    |> redirect(to: Routes.question_path(conn, :index, district_id))
  end
end
