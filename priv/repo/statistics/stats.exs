alias MusicdbRmd.ConcertsSongs
alias MusicdbRmd.Concert
alias MusicdbRmd.{Repo, Artist, Producer, Song, Genre, Album, Venue, City}
import Ecto.Query

query = fn table ->
  from(t in table)
end

max_value = fn table, field ->
  k = Repo.all(query.(table))

  l =
    Enum.max_by(k, fn val ->
      s = get_in(val, [Access.key!(field)])

      if s != nil do
        s
      else
        0
      end
    end)

  Enum.filter(k, fn val ->
    get_in(val, [Access.key!(field)]) == get_in(l, [Access.key!(field)])
  end)
end

min_value = fn table, field ->
  k = Repo.all(query.(table))

  l =
    Enum.min_by(k, fn val ->
      s = get_in(val, [Access.key!(field)])

      if s != nil do
        s
      else
        0
      end
    end)

  Enum.filter(k, fn val ->
    get_in(val, [Access.key!(field)]) == get_in(l, [Access.key!(field)])
  end)
end

format = fn enum, field1, field2, field3, field4 ->
  acc =
    if length(enum) > 1 do
      "The #{field1}s with #{field4} #{Atom.to_string(field3)} are"
    else
      "The #{field1} with #{field4} #{Atom.to_string(field3)} is"
    end

  k =
    Enum.reduce(enum, " ", fn val, acc ->
      name = get_in(val, [Access.key!(field2)])
      maxval = get_in(val, [Access.key!(field3)])
      acc <> "(#{to_string(name)}, #{to_string(maxval)}), "
    end)

  (acc <> k) |> String.trim(", ")
end

# Producer stats
query =
  from(s in Song,
    as: :song,
    inner_join: al in Album,
    as: :album,
    on: s.album_id == al.id,
    inner_join: a in Artist,
    as: :artist,
    on: s.artist_id == a.id,
    inner_join: p in Producer,
    on: al.producer_id == p.id,
    distinct: true,
    where: p.name != a.name,
    select: %{p_id: p.id, name: p.name, artists: a.name}
  )

query =
  Repo.all(query)

k1 =
  Enum.map(query, fn val ->
    val.name
  end)

producerartists =
  Enum.frequencies(k1)
  |> Enum.map(fn {val1, val2} -> %{name: val1, num_of_artists_worked: val2} end)

{producerartistsmini, producerartistsmaxi} =
  producerartists
  |> Enum.min_max_by(fn val -> val.num_of_artists_worked end)

producerartistsmaxi =
  Enum.filter(producerartists, fn val ->
    val.num_of_artists_worked == producerartistsmaxi.num_of_artists_worked
  end)

producerartistsmini =
  Enum.filter(producerartists, fn val ->
    val.num_of_artists_worked == producerartistsmini.num_of_artists_worked
  end)

producermost =
  max_value.(Producer, :total_listens)
  |> format.("producer", :name, :total_listens, "most")

producerleast =
  max_value.(Producer, :total_listens)
  |> format.("producer", :name, :total_listens, "least")

producerartistsmax =
  producerartistsmaxi
  |> format.("producer", :name, :num_of_artists_worked, "most")

producerartistsmin =
  producerartistsmini
  |> format.("producer", :name, :num_of_artists_worked, "least")

# Artist stats
q =
  from(s in Song,
    inner_join: a in Artist,
    on: s.artist_id == a.id,
    group_by: a.id,
    select: %{name: a.name, num_of_songs: count(s.id)}
  )

q = Repo.all(q)

k =
  Enum.max_by(q, fn val ->
    val.num_of_songs
  end)

l =
  Enum.min_by(q, fn val ->
    val.num_of_songs
  end)

artistmax =
  max_value.(Artist, :grammys_won)
  |> format.("artist", :name, :grammys_won, "most")

artistmin =
  min_value.(Artist, :grammys_won)
  |> format.("artist", :name, :grammys_won, "least")

artistsongmax =
  Enum.filter(q, fn val ->
    val.num_of_songs == k.num_of_songs
  end)
  |> format.("artist", :name, :num_of_songs, "most")

artistsongmin =
  Enum.filter(q, fn val ->
    val.num_of_songs == l.num_of_songs
  end)
  |> format.("artist", :name, :num_of_songs, "least")

# Album stats
albummax =
  max_value.(Album, :release_year)
  |> format.("album", :title, :release_year, "latest")

albummin =
  min_value.(Album, :release_year)
  |> format.("album", :title, :release_year, "oldest")

# Song stats
songmax =
  max_value.(Song, :total_listens)
  |> format.("song", :title, :total_listens, "most")

songmin =
  min_value.(Song, :total_listens)
  |> format.("song", :title, :total_listens, "least")

songshort =
  min_value.(Song, :duration)
  |> format.("song", :title, :duration, "shortest")

songlong =
  max_value.(Song, :duration)
  |> format.("song", :title, :duration, "longest")

# Genre songs
genrequery =
  from(s in Song,
    left_join: g in Genre,
    on: g.id == s.genre_id,
    group_by: g.id,
    select: %{name: g.name, num_of_songs: count(s.id)}
  )

que =
  Repo.all(genrequery)
  |> Enum.sort_by(fn val -> val.num_of_songs end, :desc)

# Venue stats
venuemax =
  max_value.(Venue, :capacity)
  |> format.("song", :name, :capacity, "most")

venuemin =
  min_value.(Venue, :capacity)
  |> format.("song", :name, :capacity, "least")

# City stats
queer =
  from(v in Venue,
    inner_join: c in City,
    on: c.id == v.city_id,
    group_by: c.id,
    select: %{name: c.name, num_of_venues: count(v.id)}
  )

queer =
  Repo.all(queer)

{citymini, citymaxi} = Enum.min_max_by(queer, fn val -> val.num_of_venues end)

citymax = Enum.filter(queer, fn val -> val.num_of_venues == citymaxi.num_of_venues end)
citymin = Enum.filter(queer, fn val -> val.num_of_venues == citymini.num_of_venues end)

citymax =
  citymax
  |> format.("city", :name, :num_of_venues, "most")

citymin =
  citymin
  |> format.("city", :name, :num_of_venues, "least")

# Concert stats
queeryy =
  from(c in Concert,
    inner_join: cs in ConcertsSongs,
    on: c.id == cs.concert_id,
    group_by: c.id,
    select: %{name: c.title, num_of_songs: count(cs.song_id)}
  )

queeryy =
  Repo.all(queeryy)

{concertsongmini, concertsongmaxi} = Enum.min_max_by(queeryy, fn val -> val.num_of_songs end)

concertsongmax =
  Enum.filter(queeryy, fn val -> val.num_of_songs == concertsongmaxi.num_of_songs end)

concertsongmin =
  Enum.filter(queeryy, fn val -> val.num_of_songs == concertsongmini.num_of_songs end)

concertsongmax =
  concertsongmax
  |> format.("concert", :name, :num_of_songs, "most")

concertsongmin =
  concertsongmin
  |> format.("concert", :name, :num_of_songs, "least")

# Producer stats
IO.puts("")
IO.puts("")
IO.puts("Producer's stats: ")
IO.puts(producermost)
IO.puts(producerleast)
IO.puts(producerartistsmax)
IO.puts(producerartistsmin)

# Artist print
IO.puts("")
IO.puts("")
IO.puts("Artist's stats: ")
IO.puts(artistmax)
IO.puts(artistmin)
IO.puts(artistsongmax)
IO.puts(artistsongmin)

# Album stats
IO.puts("")
IO.puts("")
IO.puts("Album's stats: ")
IO.puts(albummax)
IO.puts(albummin)

# Song stats
IO.puts("")
IO.puts("")
IO.puts("Song's stats: ")
IO.puts(songmax)
IO.puts(songmin)
IO.puts(songlong)
IO.puts(songshort)

# Genre stats
IO.puts("")
IO.puts("")
IO.puts("Genre's stats: ")

Enum.each(que, fn each ->
  IO.puts("#{String.capitalize(each.name)} has #{to_string(each.num_of_songs)} songs")
end)

# Venue stats
IO.puts("")
IO.puts("")
IO.puts("Venue's stats: ")
IO.puts(venuemax)
IO.puts(venuemin)

# city stats
IO.puts("")
IO.puts("")
IO.puts("City's stats: ")
IO.puts(citymax)
IO.puts(citymin)

# Concert stats
IO.puts("")
IO.puts("")
IO.puts("Concert's stats: ")
IO.puts(concertsongmax)
IO.puts("")
IO.puts(concertsongmin)
