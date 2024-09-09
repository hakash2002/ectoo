defmodule MusicdbRmd.VenueTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{Venue, Repo}
  alias Ecto.Changeset

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset validation" do
    a1 =
      %Venue{}
      |> Venue.changeset(%{name: "test", capacity: 60_301})

    assert %Changeset{} = a1

    a2 =
      %Venue{}
      |> Venue.changeset(%{name: "", capacity: 30_000})

    assert a2.valid? == false
  end

  test "sandbox testing" do
    venue_insert =
      %Venue{}
      |> Venue.changeset(%{name: "test", capacity: 30_000})

    venue_insert = Repo.insert!(venue_insert)
    venue_insert = Repo.get!(Venue, venue_insert.id)
    assert venue_insert.name == "test"

    venue_update = Venue.changeset(venue_insert, %{name: "testingg"})
    Repo.update!(venue_update)
    venue_update = Repo.get!(Venue, venue_insert.id)
    assert venue_update.name == "testingg"

    Repo.delete(venue_update)
    assert Repo.get(Venue, venue_update.id) == nil
  end
end
