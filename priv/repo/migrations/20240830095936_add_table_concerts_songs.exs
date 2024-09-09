defmodule MusicdbRmd.Repo.Migrations.AddTableConcertsArtists do
  use Ecto.Migration

  def change do
    create table("concerts_songs") do
      add :concert_id, references(:concerts)
      add :song_id, references(:songs)
    end

    create index("concerts_songs", :concert_id)
   end
end
