defmodule MusicdbRmd.Album do
  @moduledoc """
  Albums schema
  """
  alias MusicdbRmd.{Producer, Song}
  use Ecto.Schema
  import Ecto.Changeset

  schema "albums" do
    field(:title, :string)
    field(:release_year, :integer)
    timestamps()

    belongs_to(:producer, Producer)
    has_many(:songs, Song)
  end

  def changeset(struct, params = %{producer: %Producer{}}) do
    struct
    |> cast(params, [:title, :release_year])
    |> validate_required([:title])
    |> validate_exclusion(:title, ["NULL"])
    |> validate_number(:release_year, less_than: DateTime.utc_now().year + 1)
    |> cast_assoc(:songs, with: &Song.changeset/2)
    |> put_assoc(:producer, params.producer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :release_year])
    |> validate_required([:title])
    |> validate_exclusion(:title, ["NULL"])
    |> validate_number(:release_year, less_than: DateTime.utc_now().year + 1)
    |> cast_assoc(:songs, with: &Song.changeset/2)
    |> cast_assoc(:producer, with: &Producer.changeset/2)
  end
end
