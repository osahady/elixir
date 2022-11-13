defmodule PollerPhxWeb.ChoiceController do
  use PollerPhxWeb, :controller
  alias PollerDal.{Districts, Questions, Choices}
  alias PollerDal.{Choices.Choice}

  def index(conn, %{"district_id" => district_id, "question_id" => question_id}) do
    district = Districts.get_district!(district_id)
    question = Questions.get_question!(question_id)
    choices = Choices.list_choices_by_question_id(question_id)

    render(conn, "index.html",
      choices: choices,
      district: district,
      question: question
    )
  end

  def new(conn, %{"district_id" => district_id, "question_id" => question_id}) do
    district = Districts.get_district!(district_id)
    question = Questions.get_question!(question_id)
    changeset = Choices.change_choice(%Choice{})

    render(conn, "new.html",
      district: district,
      question: question,
      changeset: changeset
    )
  end

  def create(conn, %{
        "district_id" => district_id,
        "question_id" => question_id,
        "choice" => params
      }) do
    params =
      Map.merge(params, %{
        "district_id" => district_id,
        "question_id" => question_id
      })

    case Choices.create_choice(params) do
      {:ok, _choice} ->
        conn
        |> put_flash(:info, "Choice created successfully")
        |> redirect(to: Routes.choice_path(conn, :index, district_id, question_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{
        "district_id" => district_id,
        "question_id" => question_id,
        "id" => id
      }) do
    district = Districts.get_district!(district_id)
    question = Questions.get_question!(question_id)
    choice = Choices.get_choice!(id)
    changeset = Choices.change_choice(%Choice{})

    render(
      conn,
      "edit.html",
      district: district,
      question: question,
      choice: choice,
      changeset: changeset
    )
  end

  def delete(conn, %{
        "district_id" => district_id,
        "question_id" => question_id,
        "id" => id
      }) do
    choice = Choices.get_choice!(id)
    {:ok, _} = Choices.delete_choice(choice)

    conn
    |> put_flash(:info, "Deleted successfully")
    |> redirect(to: Routes.choice_path(conn, :index, district_id, question_id))
  end
end
