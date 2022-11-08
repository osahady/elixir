defmodule PollerDal.Choices.Choice do
  use Ecto.Schema
  import Ecto.Changeset
  alias PollerDal.Questions.Question

  @parties [
    {"Democrat", 1},
    {"Republican", 2}
  ]

  @party_ids Enum.map(@parties, &elem(&1, 1))

  schema "choices" do
    field(:description, :string)
    field(:party, :integer)
    field(:votes, :integer, default: 0)
    belongs_to(:question, Question)

    timestamps()
  end

  def changeset(choice, attrs) do
    choice
    |> cast(attrs, [:description, :question_id])
    |> validate_required([:description, :question_id])
    |> validate_inclusion(:party, @party_ids)
    |> assoc_constraint(:question)
  end
end
