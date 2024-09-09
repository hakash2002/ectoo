defmodule MusicdbRmd.AlbumTest do
  use ExUnit.Case, async: true
  alias MusicdbRmd.{Album, Repo, Producer, Song}
  import Ecto.Changeset

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(MusicdbRmd.Repo)
  end

  test "changeset validations" do
    j = Album.changeset(%Album{}, %{title: "", release_year: 2002})
    assert j.valid? == false

    k = Album.changeset(%Album{}, %{title: "test", release_year: 2002})
    assert k.valid? == true
    assert %Album{} = apply_changes(k)

    l = Album.changeset(%Album{}, %{title: "test", release_year: 2040})
    assert l.valid? == false

    m =
      Album.changeset(%Album{}, %{
        title: "test",
        release_year: 2040,
        songs: [%{title: "test", duration: 120}],
        producer: [name: "test", dob: "2020-09-20"]
      })

    assert %Producer{} = m.changes.producer.data
    assert m.changes.producer.action == :insert

    l = Repo.get_by!(Producer, name: "Kanye West")

    m =
      Album.changeset(%Album{}, %{
        title: "test2",
        release_year: 2020,
        songs: [%{title: "test", duration: 120}],
        producer: l
      })

    assert %Producer{} = m.changes.producer.data
    assert m.changes.producer.action == :update
  end

  test "sandbox testing" do
    k = Album.changeset(%Album{}, %{title: "test", release_year: 2002})
    k = Repo.insert!(k)
    %Album{} = k

    m =
      Album.changeset(%Album{}, %{
        title: "test",
        release_year: 2020,
        songs: [%{title: "test", duration: 120}, %{title: "test2", duration: 120}],
        producer: [name: "test", dob: "2020-09-02"]
      })

    m = Repo.insert!(m)
    assert %Producer{} = m.producer
    albums = Repo.get!(Album, m.id) |> Repo.preload([:producer, :songs])
    assert albums.title == "test"

    Enum.each(albums.songs, fn each ->
      assert %Song{} = each
    end)

    assert albums.producer.name == "test"

    update_album = Album.changeset(m, %{title: "testingg"})
    m = Repo.update!(update_album)
    assert m.title == "testingg"

    Repo.delete(m)
    assert Repo.get(Album, m.id) == nil
  end
end
