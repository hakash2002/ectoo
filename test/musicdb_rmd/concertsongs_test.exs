defmodule MusicdbRmd.ConcertsongsTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{ConcertsSongs, Repo, Concert, Song}

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "schema definition" do
    assert %ConcertsSongs{} = %ConcertsSongs{
             id: nil,
             concert_id: nil,
             song_id: nil
           }
  end

  test "sandbox testing" do
    concert = Repo.get!(Concert, 1)
    song = Repo.get!(Song, 1)
    concertsongs = %ConcertsSongs{song: song, concert: concert}
    insert = Repo.insert!(concertsongs)
    insert = Repo.get!(ConcertsSongs, insert.id) |> Repo.preload([:song, :concert])

    assert insert.song == song
    assert insert.concert == concert

    Repo.delete!(insert)
    assert Repo.get(ConcertsSongs, insert.id) == nil
  end
end
