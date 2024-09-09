defmodule MusicdbRmd.Repo.Migrations.CreateTableGenres do
  use Ecto.Migration

  def change do
    create table("genres") do
      add(:name, :string, null: false, unique: true)
      timestamps()
    end

    create unique_index(:genres, [:name])
  end
end
