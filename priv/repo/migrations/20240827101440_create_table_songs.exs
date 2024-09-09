defmodule MusicdbRmd.Repo.Migrations.CreateTableTracks do
  use Ecto.Migration

  def change do
    create table("songs") do
      add(:title, :string)
      add(:duration, :time)
      add(:total_listens, :integer)
      add(:album_id, references(:albums, on_delete: :delete_all))
    end

    create index("songs", [:title, :album_id])
  end
end
