defmodule MusicdbRmd.AlbumEmbeded do
  @moduledoc """
  Embeded albums with songs and producers
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias MusicdbRmd.{ProducerEmbed, SongsEmbed}

  schema "albums_with_embeds" do
    field(:title, :string)
    embeds_one(:producer, ProducerEmbed, on_replace: :update)
    embeds_many(:songs, SongsEmbed, on_replace: :delete)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title])
    |> validate_required([:title])
    |> cast_embed(:producer)
    |> cast_embed(:songs)
  end
end
