defmodule MusicdbRmd.City do
  @moduledoc """
  City schema
  """
  alias MusicdbRmd.Venue
  use Ecto.Schema
  import Ecto.Changeset

  schema "city" do
    field(:name, :string)
    field(:country, :string)
    field(:postal_code, :integer)
    has_many(:venues, Venue)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :country, :postal_code])
    |> validate_required([:name, :postal_code])
  end
end
