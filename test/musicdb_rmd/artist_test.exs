defmodule MusicdbRmd.ArtistTest do
  use ExUnit.Case, async: true
  alias Ecto.{Changeset, Adapters.SQL.Sandbox}
  alias MusicdbRmd.{Artist, Band, SoloArtist, ArtistProducer, Repo}
  import Ecto.Changeset

  setup do
    :ok = Sandbox.checkout(Repo)
  end

  test "changeset validation" do
    a = Artist.changeset(%Artist{}, %{name: "", dod: "2024-07-03", grammys_won: 23})
    assert %Changeset{} = a
    assert a.valid? == false

    b =
      Artist.changeset(%Artist{}, %{
        name: "test",
        dob: "2002-02-02",
        dod: "2024-07-03",
        grammys_won: 23
      })

    assert b.valid? == true
    assert %Artist{} = apply_changes(b)
  end

  test "changeset validation for Band struct" do
    d = %Band{name: "", start_year: 2020, end_year: 2024, grammys_won: 23}
    d = Artist.changeset(d)
    assert %Changeset{} = d
    assert d.valid? == false

    d = %Band{name: "Test", start_year: 2020, end_year: 2024, grammys_won: 23}
    d = Artist.changeset(d)
    assert %Changeset{} = d
    assert d.valid? == true

    d = %Band{name: "test", start_year: 2020, end_year: "hah", grammys_won: 23}
    d = Artist.changeset(d)
    assert %Changeset{} = d
    assert d.valid? == false
  end

  test "changeset validation for SoloArtist struct" do
    e = %SoloArtist{
      name1: "Test",
      name2: "Test2",
      name3: "Test3",
      dob: "2000-02-11",
      dod: "2020-02-22"
    }

    e = Artist.changeset(e)
    assert %Changeset{} = e
    assert e.valid? == true

    e = %SoloArtist{
      name1: "",
      dob: "2000-02-11",
      dod: "2020-02-22"
    }

    e = Artist.changeset(e)
    assert %Changeset{} = e
    assert e.valid? == false
  end

  test "changeset validation for ArtistProducer struct" do
    f = %ArtistProducer{
      name: "Test",
      dob: "2000-02-11",
      dod: "2020-02-22"
    }

    f = Artist.changeset(f)
    assert %Changeset{} = f
    assert f.valid? == true

    f = %ArtistProducer{
      name: "",
      dob: "2000-02-11",
      dod: "2020-02-22"
    }

    f = Artist.changeset(f)
    assert %Changeset{} = f
    assert f.valid? == false
  end

  test "validating custom validation functions" do
    c1 =
      Changeset.cast(%Artist{}, %{name: "test", dob: "2040-02-02", grammys_won: 23}, [
        :name,
        :dob,
        :grammys_won
      ])
      |> Artist.validating_date(:dob)

    assert c1.errors == [dob: {"Can only be in the past", []}]

    c2 =
      Changeset.cast(%Artist{}, %{name: "test", dob: "2020-02-02", grammys_won: 23}, [
        :name,
        :dob,
        :grammys_won
      ])
      |> Artist.validating_date(:dob)

    assert c2.errors == []

    c3 =
      Changeset.cast(%Artist{}, %{name: "test", grammys_won: 23}, [
        :name,
        :grammys_won
      ])
      |> Artist.validating_date(:dob)

    assert c3.errors == []

    g2 =
      Changeset.cast(
        %Artist{},
        %{name: "test", dob: "2000-02-02", dod: "2020-02-02", grammys_won: 23},
        [
          :name,
          :dob,
          :dod,
          :grammys_won
        ]
      )
      |> Artist.validating_dodagain(:dod)

    assert g2.errors == []

    g3 =
      Changeset.cast(%Artist{}, %{name: "test", dob: "2000-02-02", grammys_won: 23}, [
        :name,
        :dob,
        :grammys_won
      ])
      |> Artist.validating_dodagain(:dod)

    assert g3.errors == []

    g4 =
      Changeset.cast(
        %Artist{},
        %{name: "test", dob: "2024-02-02", dod: "2020-02-02", grammys_won: 23},
        [
          :name,
          :dob,
          :dod,
          :grammys_won
        ]
      )
      |> Artist.validating_dodagain(:dod)

    assert g4.errors == [dod: {"Can't be lesser than dob", []}]
  end

  test "sandbox testing" do
    artist_insert =
      Artist.changeset(%Artist{}, %{
        name: "test",
        dob: "2002-02-02",
        dod: "2024-07-03",
        grammys_won: 23
      })

    artist_insert = Repo.insert!(artist_insert)
    data = Repo.get!(Artist, artist_insert.id)
    assert data.name == "test"

    artist1 =
      Artist.changeset(%Artist{}, %{
        name: "The Weeknd",
        dob: "1998-06-05",
        dod: "2030-02-02",
        grammys_won: 3
      })

    assert {:error, _changeset} = Repo.insert(artist1)
    artist_update = Artist.changeset(artist_insert, %{name: "testingg"})
    Repo.update!(artist_update)
    data = Repo.get!(Artist, artist_insert.id)
    assert data.name == "testingg"

    Repo.delete!(data)
    assert Repo.get(Artist, data.id) == nil
  end
end
