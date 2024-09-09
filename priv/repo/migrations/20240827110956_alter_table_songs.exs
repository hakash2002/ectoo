defmodule MusicdbRmd.Repo.Migrations.AlterTableTracks do
  use Ecto.Migration

  def change do
    alter table("songs") do
      add(:link_to_song, :string)
      add(:genre_id, references(:genres))
      add(:artist_id, references(:artists))
      timestamps()
    end
  end
end
