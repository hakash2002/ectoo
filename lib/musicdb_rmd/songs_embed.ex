defmodule MusicdbRmd.SongsEmbed do
  import Ecto.Changeset
  @moduledoc """
  embeded schema for songs
  """
  alias MusicdbRmd.UnknownToTime
  use Ecto.Schema

  embedded_schema do
    field(:title, :string)
    field(:duration, UnknownToTime)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :duration])
    |> validate_required([:title, :duration])
  end

end
