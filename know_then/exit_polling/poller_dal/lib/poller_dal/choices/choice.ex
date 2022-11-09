defmodule PollerDal.Choices.Choice do
  use Ecto.Schema
  import Ecto.Changeset
  alias PollerDal.Questions.Question

  @parties [
    {"Democrat", 1},
    {"Republican", 2},
    {"Green", 3}
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
    |> cast(attrs, [:description, :question_id, :party, :votes])
    |> validate_required([:description, :question_id, :party])
    |> validate_inclusion(:party, @party_ids)
    |> assoc_constraint(:question)
  end

  def parties(), do: @parties
  def party_ids, do: @party_ids

  def party_description(id) do
    case Enum.find(@parties, &(elem(&1, 1) == id)) do
      nil -> ""
      {description, _} -> description
    end
  end
end
