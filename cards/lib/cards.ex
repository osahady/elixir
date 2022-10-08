defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Creating virtual cards on the deck

  ## Examples

      iex> deck = Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
      "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
      "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
      "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
      "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]
  """
  def create_deck() do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Distribute cards by `hand_size` number and
  the rest of the cards on remain on the deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 3)
      {["Ace of Spades", "Two of Spades", "Three of Spades"],
      ["Four of Spades", "Five of Spades", "Ace of Clubs", "Two of Clubs",
       "Three of Clubs", "Four of Clubs", "Five of Clubs", "Ace of Hearts",
       "Two of Hearts", "Three of Hearts", "Four of Hearts", "Five of Hearts",
       "Ace of Diamonds", "Two of Diamonds", "Three of Diamonds", "Four of Diamonds",
       "Five of Diamonds"]}
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> "file not found"
    end
  end
end
