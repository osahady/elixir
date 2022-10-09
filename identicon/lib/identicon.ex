defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  def main(input) do
    input
    |> hash_input()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares()
    |> create_pixel_area()
    |> draw_image()
    |> save(input)
  end

  def save(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_area: pixel_area}) do
    img = :egd.create(250, 250)
    fillColor = :egd.color(color)

    Enum.each(pixel_area, fn {p1, p2} ->
      :egd.filledRectangle(img, p1, p2, fillColor)
    end)

    :egd.render(img)
  end

  def create_pixel_area(%Identicon.Image{grid: grid} = image) do
    pixel_area =
      grid
      |> Enum.map(&prepare_points/1)

    %Identicon.Image{image | pixel_area: pixel_area}
  end

  def prepare_points({_val, index} = tuple) do
    # {x1, y1} is top left point
    # {x2, y2} is bottom right point
    x1 = rem(index, 5) * 50
    y1 = div(index, 5) * 50
    {{x1, y1}, {x1 + 50, y1 + 50}}
  end

  # if it is odd we gonna remove the item
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {num, _} = x ->
        rem(num, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    grid =
      hex_list
      |> Enum.chunk_every(3)
      |> List.delete_at(5)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _] = row
    row ++ [second, first]
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
