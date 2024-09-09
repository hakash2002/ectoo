defmodule MusicdbRmd.Repo.Migrations.AlterTableConcerts do
  use Ecto.Migration
  def change do
    alter table("concerts") do
      add :venue_id, references(:venues)
      timestamps(null: true)
    end
  end
end
