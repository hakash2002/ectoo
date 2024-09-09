defmodule MusicdbRmd.ArtistProducerTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias MusicdbRmd.{Artist, ArtistProducer, Producer}

  test "Changeset validations" do
    a1 =
      %ArtistProducer{}
      |> ArtistProducer.changeset(%{name: "", dob: "2002-02-03", dod: "2020-04-30"})

    assert %Changeset{} = a1
    assert a1.valid? == false

    a2 =
      %ArtistProducer{}
      |> ArtistProducer.changeset(%{name: "test", dob: "2002-02-03", dod: "2020-04-30", role: 1})

    assert %Changeset{} = a2
    assert a2.valid? == true
  end

  test "changeset conversion" do
    b1 =
      %ArtistProducer{}
      |> ArtistProducer.to_changeset(%{
        name: "test",
        dob: "2002-02-03",
        dod: "2020-04-30",
        role: 1
      })

    assert %Artist{} = b1.data

    b2 =
      %ArtistProducer{}
      |> ArtistProducer.to_changeset(%{
        name: "test",
        dob: "2002-02-03",
        dod: "2020-04-30",
        role: 2
      })

    assert %Producer{} = b2.data

    b3 =
      %ArtistProducer{}
      |> ArtistProducer.to_changeset(%{
        name: "test",
        dob: "2002-02-03",
        dod: "2020-04-30",
        role: 3
      })

    assert [%Artist{}, %Producer{}] = Enum.map(b3, fn a -> a.data end)

    b4 =
      %ArtistProducer{}
      |> ArtistProducer.to_changeset(%{
        name: "test",
        dob: "2002-02-03",
        dod: "2020-04-30",
        role: 21
      })

    assert %ArtistProducer{} = b4
  end
end
