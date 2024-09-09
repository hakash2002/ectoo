defmodule MusicdbRmd.Repo.Migrations.CreateTableProducers do
  use Ecto.Migration

  def change do
    create table("producers") do
      add :name, :string, null: false
      add :dob, :date
      add :dod, :date
      add :total_listens, :bigint
      timestamps()
    end

    create index("producers", [:name, :dob])
  end
end
