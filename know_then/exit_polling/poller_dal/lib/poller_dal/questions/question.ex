defmodule PollerDal.Questions.Question do
  use Ecto.Schema
  import Ecto.Changeset
  alias PollerDal.Districts.District

  schema "questions" do
    field(:description, :string)
    belongs_to(:district, District)

    timestamps()
  end

  def changeset(question, attrs \\ %{}) do
    question
    |> cast(attrs, [:description, :district_id])
    |> validate_required([:description, :district_id])
    # checks :district_id exists in :districts table
    |> assoc_constraint(:district)
  end
end
