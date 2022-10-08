defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "count of cards are 20" do
    assert length(Cards.create_deck()) == 20
  end

  test "simple truth" do
    assert 1 + 1 == 2
  end
end
