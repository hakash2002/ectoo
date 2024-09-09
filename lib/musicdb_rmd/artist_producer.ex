defmodule MusicdbRmd.ArtistProducer do
  @moduledoc """
  Embeded schema for artists who are producers
  """
  use Ecto.Schema
  alias MusicdbRmd.{Artist, Producer}
  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
    field(:dob, :date)
    field(:dod, :date)
    field(:role, :integer)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :dob, :dod, :role])
    |> validate_required([:name, :dob, :role])
    |> validate_exclusion(:name, ["NULL"])
    |> validate_inclusion(:role, [1, 2, 3])
  end

  def to_changeset(struct, params) do
    struct = changeset(struct, params)
    role = get_field(struct, :role)

    if struct.valid? do
      cond do
        role == 1 ->
          Artist.changeset(apply_changes(struct))

        role == 2 ->
          Producer.changeset(apply_changes(struct))

        role == 3 ->
          [
            Artist.changeset(apply_changes(struct)),
            Producer.changeset(apply_changes(struct))
          ]
      end
    else
      struct.data
    end
  end
end
