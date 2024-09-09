defmodule MusicdbRmd.Band do
  @moduledoc """
  Embeded band schema for Artists conversion
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
    field(:start_year, :integer)
    field(:end_year, :integer)
    field(:grammys_won, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :start_year, :end_year, :grammys_won])
    |> validate_required([:name, :start_year])
    |> validate_year()
  end

  def validate_year(changeset) do
    validate_change(changeset, :start_year, fn field, start_year ->
      end_year = get_field(changeset, :end_year) || Date.utc_today().year

      if start_year > end_year do
        [{field, "Can't be greater than end_year or present_year"}]
      else
        []
      end
    end)
  end
end
