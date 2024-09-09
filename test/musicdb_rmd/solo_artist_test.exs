defmodule MusicdbRmd.SoloArtistTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias MusicdbRmd.SoloArtist

  test "changeset validations" do
    c1 =
      %SoloArtist{}
      |> SoloArtist.changeset(%{name1: "haks", name2: "dhana", dob: "2002-11-24", grammys_won: 22})

    assert c1.errors == []

    c2 =
      %SoloArtist{}
      |> SoloArtist.changeset(%{name1: "", name2: "dhana", dob: "2002-11-24", grammys_won: 22})

    assert [{:name1, _something}] = c2.errors
  end

  test "custom validation" do
    b1 =
      Changeset.cast(
        %SoloArtist{},
        %{name1: "test", name2: "dhana", dob: "2002-11-24", dod: "2024-05-11", grammys_won: 22},
        [:name1, :name2, :dob, :dod, :grammys_won]
      )
      |> SoloArtist.validate_date(:dob, :dod)

    assert b1.errors == []

    b4 =
      Changeset.cast(
        %SoloArtist{},
        %{name1: "test", name2: "dhana", dob: "2002-11-24", grammys_won: 22},
        [:name1, :name2, :dob, :dod, :grammys_won]
      )
      |> SoloArtist.validate_date(:dob, :dod)

    assert b4.errors == []

    b2 =
      Changeset.cast(
        %SoloArtist{},
        %{name1: "test", name2: "dhana", dob: "2024-11-24", dod: "1999-05-11", grammys_won: 22},
        [:name1, :name2, :dob, :dod, :grammys_won]
      )
      |> SoloArtist.validate_date(:dob, :dod)

    assert b2.errors == [dob: {"Can't be greater than dod", []}]

    b3 =
      Changeset.cast(
        %SoloArtist{},
        %{name1: "test", name2: "dhana", dob: "2302-11-24", grammys_won: 22},
        [:name1, :name2, :dob, :dod, :grammys_won]
      )
      |> SoloArtist.validate_date(:dob, :dod)

    assert b3.errors == [dob: {"Can only be in the past", []}]
  end
end
