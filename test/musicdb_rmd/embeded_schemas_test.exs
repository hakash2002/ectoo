defmodule MusicdbRmd.EmbededSchemasTest do
  use ExUnit.Case
  alias Ecto.Changeset
  alias MusicdbRmd.{SongsEmbed, ProducerEmbed, AlbumEmbeded, Repo}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "embeded schemas changeset" do
    song_data = %{
      title: "Come Rain or Come Shine",
      duration: 349
    }

    song = SongsEmbed.changeset(%SongsEmbed{}, song_data)
    assert %Changeset{} = song

    producer_data = %{
      name: "Metro Boomin"
    }

    producer = ProducerEmbed.changeset(%ProducerEmbed{}, producer_data)
    assert %Changeset{} = producer

    album = %{
      title: "test",
      producer: producer_data,
      songs: [song_data]
    }

    album = AlbumEmbeded.changeset(%AlbumEmbeded{}, album)
    assert %Changeset{} = album
  end

  test "custom changeset" do
  end

  test "sandbox testing" do
    song_data = %{
      title: "Come Rain or Come Shine",
      duration: 349
    }

    producer_data = %{
      name: "Metro Boomin"
    }

    album = %{
      title: "test",
      producer: producer_data,
      songs: [song_data]
    }

    album = AlbumEmbeded.changeset(%AlbumEmbeded{}, album)
    album_insert = Repo.insert!(album)
    album_insert = Repo.get!(AlbumEmbeded, album_insert.id)
    assert album_insert.title == "test"
    assert album_insert.producer.name == "Metro Boomin"
    assert [%SongsEmbed{}] = album_insert.songs

    album_update = AlbumEmbeded.changeset(album_insert, %{title: "hehe"})
    Repo.update!(album_update)
    album_update = Repo.get!(AlbumEmbeded, album_insert.id)
    assert album_update.title == "hehe"

    Repo.delete!(album_update)

    assert Repo.get(AlbumEmbeded, album_update.id) == nil
  end
end
