defmodule MusicdbRmd.ConcertsSongs do
  @moduledoc """
  Concert and Songs join table schema
  """
  alias MusicdbRmd.{Concert, Song}
  use Ecto.Schema

  schema "concerts_songs" do
    belongs_to(:concert, Concert)
    belongs_to(:song, Song)
  end
end
