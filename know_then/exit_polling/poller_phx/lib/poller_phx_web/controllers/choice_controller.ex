defmodule PollerPhxWeb.ChoiceController do
  use PollerPhxWeb, :controller
  alias PollerDal.{Districts, Questions, Choices}
  alias PollerDal.{Districts.District, Questions.Question, Choices.Choice}

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
end
