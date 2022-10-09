defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> has_input()
  end

  def has_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end
