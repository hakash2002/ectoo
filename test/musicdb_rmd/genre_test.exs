defmodule MusicdbRmd.GenreTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{Genre, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset validation" do
    a2 =
      %Genre{}
      |> Genre.changeset(%{name: ""})

    assert a2.valid? == false

    a3 =
      %Genre{}
      |> Genre.changeset(%{name: "test"})

    assert a3.valid? == true
  end

  test "sandbox testing" do
    genre1 =
      %Genre{}
      |> Genre.changeset(%{name: "test"})

    genre1 = Repo.insert!(genre1)
    genre1 = Repo.get!(Genre, genre1.id)
    assert genre1.name == "test"

    genre2 = Genre.changeset(genre1, %{name: "testy"})
    Repo.update!(genre2)
    genre2 = Repo.get!(Genre, genre1.id)
    assert genre2.name == "testy"

    genre3 = %Genre{}
    |> Genre.changeset(%{name: "jazz"})
    assert {:error, _c} = Repo.insert(genre3)

    Repo.delete!(genre2)
    assert Repo.get(Genre, genre1.id) == nil

  end
end
