defmodule MusicdbRmd.Repo.Migrations.AddTableConcerts do
  use Ecto.Migration

  def change do
    create table("concerts") do
      add :title, :string, null: false
      add :conducted_date, :date, null: false
    end

    create index("concerts", [:title, :conducted_date])
  end
end
