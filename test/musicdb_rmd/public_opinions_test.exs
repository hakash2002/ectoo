defmodule MusicdbRmd.PublicOpinionsTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{PublicOpinions, Artist, Producer, Repo, Concert, Song, Album}
  alias Ecto.Changeset

  setup  do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "schema definiton" do
    assert %PublicOpinions{} = %PublicOpinions{
             author: nil,
             comment: nil,
             album: nil,
             song: nil,
             producer: nil,
             artist: nil,
             concert: nil
           }
  end

  test "changeset validation" do
    k =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "test",
        author: "test",
        artist: %Artist{}
      })

    assert %Changeset{} = k
    assert k.valid? == true

    k =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "test",
        author: "test",
        producer: %Producer{},
        artist: %Artist{}
      })

    assert %Changeset{} = k
    assert k.valid? == false
    assert k.errors == [parameters: {"Number of associate parameters should be strictly one", []}]
  end

  test "sandbox testing" do
    artist = Repo.get(Artist, 1)
    producer = Repo.get(Producer, 1)
    concert = Repo.get(Concert, 1)
    song = Repo.get(Song, 1)
    album = Repo.get(Album, 1)

    artist =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "The GOAT",
        author: "haks",
        artist: artist
      })
      |> Repo.insert!()

    assert Repo.get(PublicOpinions, artist.id).comment == "The GOAT"

    producer =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "Magician",
        author: "someone",
        producer: producer
      })
      |> Repo.insert!()

    assert Repo.get(PublicOpinions, producer.id).comment == "Magician"

    album =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "Pleasing",
        author: "someone",
        album: album
      })
      |> Repo.insert!()

    assert Repo.get(PublicOpinions, album.id).comment == "Pleasing"

    concert =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "120 DB!!",
        author: "noone",
        concert: concert
      })
      |> Repo.insert!()

    assert Repo.get(PublicOpinions, concert.id).comment == "120 DB!!"

    songs =
      PublicOpinions.changeset(%PublicOpinions{}, %{
        comment: "Unique in its genre",
        author: "anyone",
        song: song
      })
      |> Repo.insert!()

    assert Repo.get(PublicOpinions, songs.id).comment == "Unique in its genre"

    song_update =
      PublicOpinions.changeset(songs, %{
        comment: "Unique brooo",
        author: "anyone",
        song: song
      })
      |> Repo.update!()

    assert Repo.get(PublicOpinions, song_update.id).comment == "Unique brooo"

    Repo.delete!(song_update)

    assert Repo.get(PublicOpinions, song_update.id) == nil
  end
end
