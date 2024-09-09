defmodule MusicdbRmd.Repo.Migrations.CreateTableAlbum do
  use Ecto.Migration

  def change do
    create table("albums") do
      add(:title, :string, null: false)
      add(:release_year, :integer)
      add :producer_id, references(:producers, on_delete: :delete_all)
      timestamps()
    end

    create index("albums", [:title, :producer_id])
  end
end
