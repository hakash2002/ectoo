defmodule MusicdbRmd.Repo.Migrations.AlterTableArtists do
  use Ecto.Migration

  def change do
    create unique_index("artists", [:name, :dob, :dod])
  end
end
