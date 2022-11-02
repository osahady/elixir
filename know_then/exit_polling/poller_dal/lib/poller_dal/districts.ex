defmodule PollerDal.Districts do
  alias PollerDal.Repo
  alias PollerDal.Districts.District

  def create(%District{}, attrs) do
    %District{}
    |> District.changeset(attrs)
    |> Repo.insert()
  end

  def update(%District{} = district, attrs) do
    district
    |> District.changeset(attrs)
    |> Repo.update()
  end

  def delete(%District{} = district) do
    Repo.delete(district)
  end

  def list_districts(), do: Repo.all(District)

  def get_district!(id), do: Repo.get!(District, id)
end
