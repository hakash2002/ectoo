defmodule MusicdbRmd.PublicOpinions do
  @moduledoc """
  Schema for public_opinions table
  """
  alias MusicdbRmd.{Album, Artist, Song, Producer, Concert}
  use Ecto.Schema
  import Ecto.Changeset

  schema "public_opinions" do
    field(:comment, :string)
    field(:author, :string)
    belongs_to(:artist, Artist)
    belongs_to(:album, Album)
    belongs_to(:song, Song)
    belongs_to(:producer, Producer)
    belongs_to(:concert, Concert)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:comment, :author])
    |> validate_required([:comment, :author])
    |> checkingparams(params)
    |> put_assoc(:artist, Map.get(params, :artist))
    |> put_assoc(:producer, Map.get(params, :producer))
    |> put_assoc(:song, Map.get(params, :song))
    |> put_assoc(:concert, Map.get(params, :concert))
    |> put_assoc(:album, Map.get(params, :album))


  end

  defp checkingparams(changeset, params) do
    a = Map.has_key?(params, :artist) |> simplecount()
    b = Map.has_key?(params, :producer) |> simplecount()
    c = Map.has_key?(params, :concert) |> simplecount()
    d = Map.has_key?(params, :song) |> simplecount()
    e = Map.has_key?(params, :album) |> simplecount()

    if (a + b + c + d + e) == 1 do
      changeset
    else
      add_error(changeset, :parameters, "Number of associate parameters should be strictly one")
    end
  end

  defp simplecount(val) do
    if val == true do
      1
    else
      0
    end
  end

end
