defmodule MusicdbRmd.CityTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{City, Repo}
  alias Ecto.Changeset

  setup  do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset validation" do
    a1 =
      %City{}
      |> City.changeset(%{name: "test", country: "test1", postal_code: 600_301})

    assert %Changeset{} = a1

    a2 =
      %City{}
      |> City.changeset(%{name: "", country: "test1"})

    assert a2.valid? == false
  end

  test "sandbox testing" do
    city_insert =
      %City{}
      |> City.changeset(%{name: "test", country: "test1", postal_code: 600_301})

    city_insert = Repo.insert!(city_insert)
    city_insert = Repo.get!(City, city_insert.id)
    assert city_insert.name == "test"

    city_update = City.changeset(city_insert, %{name: "testingg"})
    Repo.update!(city_update)
    city_update = Repo.get!(City, city_insert.id)
    assert city_update.name == "testingg"

    Repo.delete(city_update)
    assert Repo.get(City, city_update.id) == nil
  end
end
