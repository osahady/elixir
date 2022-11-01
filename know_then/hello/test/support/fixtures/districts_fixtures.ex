defmodule Hello.DistrictsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Hello.Districts` context.
  """

  @doc """
  Generate a district.
  """
  def district_fixture(attrs \\ %{}) do
    {:ok, district} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Hello.Districts.create_district()

    district
  end
end
