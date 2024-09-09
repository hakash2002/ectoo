defmodule MusicdbRmd.SongTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.Genre
  alias Ecto.Changeset
  alias MusicdbRmd.{Song, Repo, Artist, Song}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "changeset validations and sandbox tests" do
    a1 =
      %Song{}
      |> Song.changeset(%{title: "Kadal Raasa", duration: 120, total_listens: 300_000})

    assert %Changeset{} = a1
    assert a1.valid? == true

    a2 =
      %Song{}
      |> Song.changeset(%{title: "", duration: "120", total_listens: 300_000})

    assert a2.valid? == false

    artist = Repo.get!(Artist, 1)
    genre = Repo.get!(Genre, 1)

    artist1 = %{name: "test", dob: "2020-02-12"}
    genre1 = %{name: "test"}

    song1 = Song.changeset(%Song{}, %{title: "test", duration: 121, artist: artist, genre: genre})
    assert {song1.changes.artist.action, song1.changes.genre.action} == {:update, :update}

    song1 = Repo.insert!(song1)
    song1 = Repo.get!(Song, song1.id)
    assert song1.title == "test"

    song2 =
      Song.changeset(%Song{}, %{title: "test2", duration: 121, artist: artist1, genre: genre})

    assert {song2.changes.artist.action, song2.changes.genre.action} == {:insert, :update}
    song2 = Repo.insert!(song2)
    song2 = Repo.get!(Song, song2.id)
    assert song2.title == "test2"

    song3 =
      Song.changeset(%Song{}, %{title: "test3", duration: 121, artist: artist, genre: genre1})

    assert {song3.changes.artist.action, song3.changes.genre.action} == {:update, :insert}
    song3 = Repo.insert!(song3)
    song3 = Repo.get!(Song, song3.id)
    assert song3.title == "test3"

    song4 =
      Song.changeset(%Song{}, %{title: "test4", duration: 121, artist: artist, genre: genre1})

    assert {song4.changes.artist.action, song4.changes.genre.action} == {:update, :insert}
    {:error, _changeset} = Repo.insert(song4)

    song5 =
      Song.changeset(song3, %{title: "test5", duration: 121})
      |> Repo.update!()

    song5 = Repo.get!(Song, song5.id)
    assert song5.title == "test5"

    Repo.delete!(song5)
    assert Repo.get(Song, song5.id) == nil
  end
end
