defmodule MusicdbRmd.Artist do
  @moduledoc """
  Artists schema
  """
  alias MusicdbRmd.{Song, SoloArtist, Band, ArtistProducer, Artist}
  use Ecto.Schema
  import Ecto.Changeset

  schema "artists" do
    field(:name, :string)
    field(:dob, :date)
    field(:dod, :date)
    field(:grammys_won, :integer)
    timestamps()
    has_many(:songs, Song, on_replace: :nilify)
  end


  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :dob, :dod, :grammys_won])
    |> validate_required([:name, :dob])
    |> validate_exclusion(:name, ["NULL"])
    |> validating_date(:dob)
    |> validating_dodagain(:dod)
    |> unique_constraint([:name, :dob])
  end

  def changeset(band = %Band{}) do
    start_year = %Date{year: band.start_year, month: 01, day: 01}
    end_year = %Date{year: band.end_year, month: 12, day: 31}

    changeset(%Artist{}, %{
      name: band.name,
      dob: start_year,
      dod: end_year,
      grammys_won: band.grammys_won
    })
  end

  def changeset(solo = %SoloArtist{}) do
    name = "#{solo.name1} #{solo.name2} #{solo.name3}" |> String.trim()

    changeset(%Artist{}, %{
      name: name,
      dob: solo.dob,
      dod: solo.dod,
      grammys_won: solo.grammys_won
    })
  end

  def changeset(artistprod = %ArtistProducer{}) do
    changeset(%Artist{}, %{
      name: artistprod.name,
      dob: artistprod.dob,
      dod: artistprod.dod
    })
  end

  def validating_dodagain(changeset, field) do
    validate_change(changeset, field, fn field, value ->
      dob = get_field(changeset, :dob)

      cond do
        is_nil(dob) ->
          [{:dob, "Can't leave dob blank"}]

        Date.diff(value, dob) < 0 ->
          [{field, "Can't be lesser than dob"}]

        true ->
          []
      end
    end)
  end

  def validating_date(changeset, field) do
    validate_change(changeset, field, fn field, value ->
      if Date.diff(Date.utc_today(), value) > 0 do
        []
      else
        [{field, "Can only be in the past"}]
      end
    end)
  end
end
