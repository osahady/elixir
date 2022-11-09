defmodule PollerPhxWeb.ChoiceView do
  alias PollerDal.Choices
  use PollerPhxWeb, :view

  def choice_party_options(), do: Choices.parties()

  defdelegate party_description(id), to: Choices
end
