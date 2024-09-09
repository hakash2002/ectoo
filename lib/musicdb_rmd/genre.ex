defmodule MusicdbRmd.Genre do
  @moduledoc """
  Genre schema
  """
  alias MusicdbRmd.Song
  use Ecto.Schema
  import Ecto.Changeset

  schema "genres" do
    field(:name, :string)
    timestamps()
    has_many(:songs, Song)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> validate_required(:name)
    |> unique_constraint(:name, name: :genres_name_index)
  end
end
