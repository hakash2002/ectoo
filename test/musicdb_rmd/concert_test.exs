defmodule MusicdbRmd.ConcertTest do
  use ExUnit.Case
  alias MusicdbRmd.{Concert, Repo}
  alias Ecto.Changeset

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset validation" do
    a1 =
      %Concert{}
      |> Concert.changeset(%{title: "test", conducted_date: "2020-02-20"})

    assert %Changeset{} = a1

    a2 =
      %Concert{}
      |> Concert.changeset(%{title: "", conducted_date: "2020-02-20"})

    assert a2.valid? == false
  end

  test "sandbox testing" do
    concert_insert =
      %Concert{}
      |> Concert.changeset(%{title: "test", conducted_date: "2020-02-20"})

    concert_insert = Repo.insert!(concert_insert)
    concert_insert = Repo.get!(Concert, concert_insert.id)
    assert concert_insert.title == "test"

    concert_update = Concert.changeset(concert_insert, %{title: "testingg"})
    Repo.update!(concert_update)
    concert_update = Repo.get!(Concert, concert_insert.id)
    assert concert_update.title == "testingg"

    Repo.delete(concert_update)
    assert Repo.get(Concert, concert_update.id) == nil
  end
end
