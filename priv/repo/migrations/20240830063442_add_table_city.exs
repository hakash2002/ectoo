defmodule MusicdbRmd.Repo.Migrations.AddTableCity do
  use Ecto.Migration

  def change do
    create table("city") do
      add :name, :string, null: false
      add :country, :string
      add :postal_code, :integer, null: false
    end

    create unique_index("city", [:name, :postal_code])
  end
end
