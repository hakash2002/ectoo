defmodule MusicdbRmd.Repo.Migrations.AddTableAlbumWithEmbeds do
  use Ecto.Migration

  def change do
    create table("albums_with_embeds") do
      add :title, :string
      add :producer, :jsonb
      add :songs, {:array, :jsonb}, default: []
    end

  end
end
