defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    hex_list
    |> Enum.chunk_every(3)
    |> List.delete_at(5)
  end

  def mirror_row(list) do
    list = Enum.reverse(list)
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
