defmodule MusicdbRmd.Repo.Migrations.AddTableVenues do
  use Ecto.Migration

  def change do
    create table("venues") do
      add :name, :string, null: false
      add :capacity, :integer
      add :city_id, references(:city)
    end

    create index("venues", [:name, :city_id])

  end
end
