defmodule MusicdbRmd.ProducerEmbed do
  @moduledoc """
  Embeded schema for producers
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:name, :string)
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
    |> validate_required(:name)
  end
end
