defmodule MusicdbRmd.Repo.Migrations.CreateTableArtist do
  use Ecto.Migration

  def change do
    create table("artists") do
      add(:name, :string, null: false)
      add(:dob, :date)
      add(:dod, :date)
      add(:grammys_won, :integer)
      timestamps()
    end

    create unique_index("artists", [:name, :dob])
  end
end
