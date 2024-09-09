defmodule MusicdbRmd.Producer do
  @moduledoc """
  Producer schema
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias MusicdbRmd.{Producer, ArtistProducer}
  alias MusicdbRmd.Album
  alias MusicdbRmd.Artist, as: Helper

  schema "producers" do
    field(:name, :string)
    field(:dob, :date)
    field(:dod, :date)
    field(:total_listens, :integer)
    has_many(:albums, Album)
    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :dob, :dod, :total_listens])
    |> validate_required(:name)
    |> Helper.validating_date(:dob)
    |> Helper.validating_date(:dod)
    |> Helper.validating_dodagain(:dod)
  end

  def changeset(artistprod = %ArtistProducer{}) do
    changeset(%Producer{}, %{
      name: artistprod.name,
      dob: artistprod.dob,
      dod: artistprod.dod
    })
  end
end
