defmodule MusicdbRmd.SoloArtist do
  @moduledoc """
    Embeded soloartists schema for Artists conversion
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:name1, :string)
    field(:name2, :string)
    field(:name3, :string)
    field(:dob, :date)
    field(:dod, :date)
    field(:grammys_won, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name1, :name2, :name3, :dob, :dod])
    |> validate_required([:name1, :dob])
    |> validate_exclusion(:name1, ["NULL"])
    |> validate_date(:dob, :dod)
  end

  def validate_date(changeset, date1, date2) do
    validate_change(changeset, date1, fn date1, value1 ->
      value2 = get_field(changeset, date2) || Date.from_iso8601!("3000-12-31")

      cond do
        Date.utc_today().year < value1.year ->
          [{date1, "Can only be in the past"}]

        Date.compare(value1, value2) == :gt ->
          [{date1, "Can't be greater than #{Atom.to_string(date2)}"}]

        true ->
          []
      end
    end)
  end
end
