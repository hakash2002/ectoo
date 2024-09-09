defmodule MusicdbRmd.Concert do
  @moduledoc """
  Concert schema
  """
  alias MusicdbRmd.{Song, Venue}
  use Ecto.Schema
  import Ecto.Changeset

  schema "concerts" do
    field(:title, :string)
    field(:conducted_date, :date)
    belongs_to(:venue, Venue)
    many_to_many(:songs, Song, join_through: "concerts_songs")
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :conducted_date])
    |> validate_required([:title, :conducted_date])
  end
end
