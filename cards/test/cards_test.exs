defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "count of cards are 20" do
    assert length(Cards.create_deck()) == 20
  end

  test "cards are shuffled" do
    deck = Cards.create_deck()
    shuffledDeck = Cards.shuffle(deck)
    refute(deck == shuffledDeck)
  end

  test "simple truth" do
    assert 1 + 1 == 2
  end
end
