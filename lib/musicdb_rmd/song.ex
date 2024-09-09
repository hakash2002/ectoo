defmodule MusicdbRmd.Song do
  @moduledoc """
  Song schema
  """
  alias MusicdbRmd.{Genre, Album, Artist, Concert, UnknownToTime}
  use Ecto.Schema
  import Ecto.Changeset

  schema "songs" do
    field(:title, :string)
    field(:duration, UnknownToTime)
    field(:total_listens, :integer)
    field(:link_to_song, :string)
    timestamps()
    belongs_to(:album, Album)
    belongs_to(:genre, Genre)
    belongs_to(:artist, Artist)
    many_to_many(:concerts, Concert, join_through: "concerts_songs")
  end

  defp artist_association(changeset, params) when not is_nil(params.artist) do
    if is_struct(params.artist, Artist) do
      changeset
      |> put_assoc(:artist, params.artist)
    else
      changeset
      |> cast_assoc(:artist, with: &Artist.changeset/2)
    end
  end

  defp artist_association(changeset, _params) do
    changeset
  end

  defp genre_association(changeset, params) when not is_nil(params.genre) do
    if is_struct(params.genre, Genre) do
      changeset
      |> put_assoc(:genre, params.genre)
    else
      changeset
      |> cast_assoc(:genre, with: &Genre.changeset/2)
    end
  end

  defp genre_association(changeset, _params) do
    changeset
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :duration, :total_listens])
    |> validate_required([:title, :duration])
    |> artist_association(params)
    |> genre_association(params)
  end
end
