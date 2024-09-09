defmodule MusicdbRmd.Venue do
  @moduledoc """
  Venue schema
  """
  alias MusicdbRmd.{City, Concert}
  use Ecto.Schema
  import Ecto.Changeset

  schema "venues" do
    field(:name, :string)
    field(:capacity, :integer)
    belongs_to(:city, City)
    has_many(:concert, Concert)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :capacity])
    |> validate_required([:name])
  end
end
