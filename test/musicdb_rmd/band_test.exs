defmodule MusicdbRmd.BandTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias MusicdbRmd.Band

  test "changeset validations" do
    a =
      %Band{}
      |> Band.changeset(%{name: "Test band", start_year: 2020, end_year: 2024, grammys_won: 20})

    assert %Changeset{} = a
    assert a.errors == []

    b =
      %Band{}
      |> Band.changeset(%{name: "Test band", start_year: 2027})

    assert [{:start_year, _doesntmatter}] = b.errors
  end

  test "custom validation" do
    b1 =
      %Band{}
      |> Changeset.cast(%{name: "Test band", start_year: 2020, end_year: 2024, grammys_won: 20}, [
        :name,
        :start_year,
        :end_year,
        :grammys_won
      ])
      |> Band.validate_year()

    assert b1.errors == []

    b2 =
      %Band{}
      |> Changeset.cast(%{name: "Test band", start_year: 2025, end_year: 2024, grammys_won: 20}, [
        :name,
        :start_year,
        :end_year,
        :grammys_won
      ])
      |> Band.validate_year()

    assert b2.errors == [{:start_year, {"Can't be greater than end_year or present_year", []}}]

    b3 =
      %Band{}
      |> Changeset.cast(%{name: "Test band", start_year: 2025, grammys_won: 20}, [
        :name,
        :start_year,
        :end_year,
        :grammys_won
      ])
      |> Band.validate_year()

    assert b3.errors == [{:start_year, {"Can't be greater than end_year or present_year", []}}]
  end
end
