defmodule Disscuss.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(record, attrs \\ %{}) do
    record
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
