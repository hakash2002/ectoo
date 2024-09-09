defmodule MusicdbRmd.Repo.Migrations.AddTablePublicOpinions do
  use Ecto.Migration

  def change do
    create table("public_opinions") do
      add(:comment, :string)
      add(:author, :string)
      add(:artist_id, references(:artists))
      add(:producer_id, references(:producers))
      add(:album_id, references(:albums))
      add(:concert_id, references(:concerts))
      add(:song_id, references(:songs))
      timestamps()
    end

    fk_check = """
    (CASE WHEN artist_id IS NULL THEN 0 ELSE 1 END) +
    (CASE WHEN album_id IS NULL THEN 0 ELSE 1 END) +
    (CASE WHEN song_id IS NULL THEN 0 ELSE 1 END) +
    (CASE WHEN producer_id IS NULL THEN 0 ELSE 1 END) +
    (CASE WHEN concert_id IS NULL THEN 0 ELSE 1 END) = 1
    """

    create(constraint(:public_opinions, :only_one_fk, check: fk_check))
  end
end
