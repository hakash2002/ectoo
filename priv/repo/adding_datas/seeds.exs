alias MusicdbRmd.{
  Repo,
  Artist,
  Album,
  Genre,
  Producer,
  City,
  Song,
  ConcertsSongs,
  Venue,
  Concert,
  AlbumEmbeded,
  ArtistProducer,
  PublicOpinions
}

# Genres
pop = Repo.insert!(%Genre{name: "pop"})
jazz = Repo.insert!(%Genre{name: "jazz"})
bass = Repo.insert!(%Genre{name: "bass"})
soul = Repo.insert!(%Genre{name: "soul"})
hip_hop = Repo.insert!(%Genre{name: "Hip-Hop"})
r_b = Repo.insert!(%Genre{name: "R&B"})
rock = Repo.insert!(%Genre{name: "rock"})
disco = Repo.insert!(%Genre{name: "Disco"})
rap = Repo.insert!(%Genre{name: "Rap"})

# Artists
artist1 = %{name: "The Weeknd", dob: "1998-06-05", dod: "", grammys_won: 3}
artist2 = %{name: "Drake", dob: "1986-10-24", dod: "", grammys_won: 4}
artist3 = %{name: "Beyoncé", dob: "1981-09-04", dod: "", grammys_won: 28}
artist4 = %{name: "Michael Jackson", dob: "1958-08-29", dod: "2009-06-25", grammys_won: 13}
artist5 = %{name: "Whitney Houston", dob: "1963-08-09", dod: "2012-02-11", grammys_won: 6}
artist6 = %{name: "Prince", dob: "1958-06-07", dod: "2016-04-21", grammys_won: 7}
artist7 = %{name: "Amy Winehouse", dob: "1983-09-14", dod: "2011-07-23", grammys_won: 6}
artist8 = %{name: "David Bowie", dob: "1947-01-08", dod: "2016-01-10", grammys_won: 6}
artist9 = %{name: "Dr. Dre", dob: "1965-02-18", dod: "", grammys_won: 7}
artist10 = %{name: "Freddie Mercury", dob: "1946-09-05", dod: "1991-11-24", grammys_won: 4}

artistenum = [
  artist1,
  artist2,
  artist3,
  artist4,
  artist5,
  artist6,
  artist7,
  artist8,
  artist9,
  artist10
]

artistenum =
  Enum.map(
    artistenum,
    fn each ->
      Repo.insert!(Artist.changeset(%Artist{}, each))
    end
  )

# producers
producer1 = %{name: "The Weeknd", dob: "1971-02-26", dod: "", total_listens: 10_000_000_000}
producer2 = %{name: "Quincy Jones", dob: "1933-03-14", dod: "", total_listens: 3_500_000_000}
producer3 = %{name: "Rick Rubin", dob: "1963-03-10", dod: "", total_listens: 2_800_000_000}

producer4 = %{
  name: "Phil Spector",
  dob: "1939-12-26",
  dod: "2021-01-16",
  total_listens: 2_200_000_000
}

producer5 = %{
  name: "George Martin",
  dob: "1926-01-03",
  dod: "2016-03-08",
  total_listens: 3_000_000_000
}

producer6 = %{name: "Linda Perry", dob: "1965-04-15", dod: "", total_listens: 1_800_000_000}
producer7 = %{name: "Kanye West", dob: "1977-06-08", dod: "", total_listens: 5_000_000_000}
producer8 = %{name: "Jimmy Iovine", dob: "1953-03-11", dod: "", total_listens: 2_100_000_000}
producer9 = %{name: "Brian Eno", dob: "1948-05-15", dod: "", total_listens: 1_600_000_000}

producer10 = %{
  name: "J Dilla",
  dob: "1974-02-07",
  dod: "2006-02-10",
  total_listens: 1_200_000_000
}

producerenum = [
  producer1,
  producer2,
  producer3,
  producer4,
  producer5,
  producer6,
  producer7,
  producer8,
  producer9,
  producer10
]

producerenum =
  Enum.map(
    producerenum,
    fn each ->
      Repo.insert!(Producer.changeset(%Producer{}, each))
    end
  )

# albums
album1_songs =
  [
    %{
      title: "I Was Never There",
      duration: 120,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 0),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Hurt You",
      duration: 150,
      total_listens: 180_000_000,
      artist: Enum.at(artistenum, 0),
      genre: r_b,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Call Out My Name",
      duration: 210,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 0),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Privilege",
      duration: 145,
      total_listens: 100_000_000,
      artist: Enum.at(artistenum, 0),
      genre: r_b,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Try Me",
      duration: 180,
      total_listens: 220_000_000,
      artist: Enum.at(artistenum, 0),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album2_songs =
  [
    %{
      title: "Thriller",
      duration: 357,
      total_listens: 500_000_000,
      artist: Enum.at(artistenum, 3),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Billie Jean",
      duration: 294,
      total_listens: 450_000_000,
      artist: Enum.at(artistenum, 3),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Beat It",
      duration: 258,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 3),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Human Nature",
      duration: 222,
      total_listens: 280_000_000,
      artist: Enum.at(artistenum, 3),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "P.Y.T. (Pretty Young Thing)",
      duration: 239,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 3),
      genre: disco,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album3_songs =
  [
    %{
      title: "Hello",
      duration: 295,
      total_listens: 600_000_000,
      artist: Enum.at(artistenum, 2),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Send My Love",
      duration: 223,
      total_listens: 400_000_000,
      artist: Enum.at(artistenum, 0),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "When We Were Young",
      duration: 290,
      total_listens: 350_000_000,
      artist: Enum.at(artistenum, 2),
      genre: disco,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Water Under the Bridge",
      duration: 240,
      total_listens: 250_000_000,
      artist: Enum.at(artistenum, 8),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "All I Ask",
      duration: 273,
      total_listens: 150_000_000,
      artist: Enum.at(artistenum, 2),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album4_songs =
  [
    %{
      title: "DNA.",
      duration: 210,
      total_listens: 500_000_000,
      artist: Enum.at(artistenum, 6),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "LOYALTY.",
      duration: 227,
      total_listens: 400_000_000,
      artist: Enum.at(artistenum, 4),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "HUMBLE.",
      duration: 177,
      total_listens: 600_000_000,
      artist: Enum.at(artistenum, 6),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "LOVE.",
      duration: 216,
      total_listens: 350_000_000,
      artist: Enum.at(artistenum, 6),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "ELEMENT.",
      duration: 223,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 6),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album5_songs =
  [
    %{
      title: "Nuthin' But a 'G' Thang",
      duration: 242,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 8),
      genre: rap,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Let Me Ride",
      duration: 220,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 8),
      genre: rap,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "The Day the Niggaz Took Over",
      duration: 254,
      total_listens: 180_000_000,
      artist: Enum.at(artistenum, 8),
      genre: rap,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Fuck Wit Dre Day",
      duration: 271,
      total_listens: 150_000_000,
      artist: Enum.at(artistenum, 8),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Lil' Ghetto Boy",
      duration: 280,
      total_listens: 100_000_000,
      artist: Enum.at(artistenum, 8),
      genre: hip_hop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album6_songs =
  [
    %{
      title: "Rehab",
      duration: 216,
      total_listens: 600_000_000,
      artist: Enum.at(artistenum, 5),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "You Know I'm No Good",
      duration: 244,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 5),
      genre: jazz,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Back to Black",
      duration: 240,
      total_listens: 400_000_000,
      artist: Enum.at(artistenum, 8),
      genre: r_b,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Tears Dry on Their Own",
      duration: 225,
      total_listens: 250_000_000,
      artist: Enum.at(artistenum, 5),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Love Is a Losing Game",
      duration: 167,
      total_listens: 180_000_000,
      artist: Enum.at(artistenum, 8),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album7_songs =
  [
    %{
      title: "Dreams",
      duration: 252,
      total_listens: 350_000_000,
      artist: Enum.at(artistenum, 4),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Go Your Own Way",
      duration: 221,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 7),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "The Chain",
      duration: 272,
      total_listens: 280_000_000,
      artist: Enum.at(artistenum, 7),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Don't Stop",
      duration: 209,
      total_listens: 240_000_000,
      artist: Enum.at(artistenum, 7),
      genre: rock,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Gold Dust Woman",
      duration: 304,
      total_listens: 180_000_000,
      artist: Enum.at(artistenum, 7),
      genre: bass,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album8_songs =
  [
    %{
      title: "Bohemian Rhapsody",
      duration: 354,
      total_listens: 700_000_000,
      artist: Enum.at(artistenum, 5),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "You're My Best Friend",
      duration: 166,
      total_listens: 150_000_000,
      artist: Enum.at(artistenum, 5),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Love of My Life",
      duration: 205,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 4),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Death on Two Legs",
      duration: 228,
      total_listens: 100_000_000,
      artist: Enum.at(artistenum, 5),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Seaside Rendezvous",
      duration: 158,
      total_listens: 50_000_000,
      artist: Enum.at(artistenum, 5),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album9_songs =
  [
    %{
      title: "Rolling in the Deep",
      duration: 228,
      total_listens: 500_000_000,
      artist: Enum.at(artistenum, 2),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Someone Like You",
      duration: 285,
      total_listens: 400_000_000,
      artist: Enum.at(artistenum, 2),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Set Fire to the Rain",
      duration: 242,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 4),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Rumour Has It",
      duration: 223,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 2),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Turning Tables",
      duration: 251,
      total_listens: 150_000_000,
      artist: Enum.at(artistenum, 0),
      genre: soul,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

album10_songs =
  [
    %{
      title: "King Kunta",
      duration: 238,
      total_listens: 400_000_000,
      artist: Enum.at(artistenum, 6),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "Alright",
      duration: 223,
      total_listens: 450_000_000,
      artist: Enum.at(artistenum, 6),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "The Blacker the Berry",
      duration: 342,
      total_listens: 300_000_000,
      artist: Enum.at(artistenum, 6),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "i",
      duration: 195,
      total_listens: 250_000_000,
      artist: Enum.at(artistenum, 6),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    },
    %{
      title: "How Much a Dollar Cost",
      duration: 247,
      total_listens: 200_000_000,
      artist: Enum.at(artistenum, 6),
      genre: pop,
      link_to_song: "https://www.youtube.com/watch?v=dummy_link27"
    }
  ]

# Albums
album1 = %{
  title: "My Dear Melancholy",
  release_year: 2019,
  producer: Enum.at(producerenum, 1),
  songs: album1_songs
}

album2 = %{
  title: "Thriller",
  release_year: 1982,
  producer: Enum.at(producerenum, 1),
  songs: album2_songs
}

album3 = %{
  title: "25",
  release_year: 2015,
  producer: Enum.at(producerenum, 2),
  songs: album3_songs
}

album4 = %{
  title: "DAMN.",
  release_year: 2017,
  producer: Enum.at(producerenum, 3),
  songs: album4_songs
}

album5 = %{
  title: "The Chronic",
  release_year: 1992,
  producer: Enum.at(producerenum, 4),
  songs: album5_songs
}

album6 = %{
  title: "Back to Black",
  release_year: 2006,
  producer: Enum.at(producerenum, 5),
  songs: album6_songs
}

album7 = %{
  title: "Rumours",
  release_year: 1977,
  producer: Enum.at(producerenum, 6),
  songs: album7_songs
}

album8 = %{
  title: "A Night at the Opera",
  release_year: 1975,
  producer: Enum.at(producerenum, 7),
  songs: album8_songs
}

album9 = %{
  title: "21",
  release_year: 2011,
  producer: Enum.at(producerenum, 8),
  songs: album9_songs
}

album10 = %{
  title: "To Pimp a Butterfly",
  release_year: 2015,
  producer: Enum.at(producerenum, 9),
  songs: album10_songs
}

albumenum = [album1, album2, album3, album4, album5, album6, album7, album8, album9, album10]

albumenum = Enum.each(albumenum, fn each -> Album.changeset(%Album{}, each) |> Repo.insert!() end)
IO.inspect(albumenum)

# cities
city1 = Repo.insert!(%City{name: "Las Vegas", postal_code: 300_079, country: "USA"})
city2 = Repo.insert!(%City{name: "New York", postal_code: 100_001, country: "USA"})
city3 = Repo.insert!(%City{name: "Toronto", postal_code: 400_110, country: "Canada"})
city4 = Repo.insert!(%City{name: "London", postal_code: 200_091, country: "UK"})
city5 = Repo.insert!(%City{name: "Sydney", postal_code: 500_045, country: "Australia"})
city6 = Repo.insert!(%City{name: "Tokyo", postal_code: 600_102, country: "Japan"})
city7 = Repo.insert!(%City{name: "Paris", postal_code: 750_011, country: "France"})
city8 = Repo.insert!(%City{name: "Berlin", postal_code: 800_101, country: "Germany"})
city9 = Repo.insert!(%City{name: "Rio de Janeiro", postal_code: 900_121, country: "Brazil"})
city10 = Repo.insert!(%City{name: "Mumbai", postal_code: 700_081, country: "India"})
city11 = Repo.insert!(%City{name: "Dubai", postal_code: 200_011, country: "UAE"})

# venues
venue1 = Repo.insert!(%Venue{name: "Hard Rock Stadium", capacity: 35_000, city: city1})
venue2 = Repo.insert!(%Venue{name: "Madison Square Garden", capacity: 20_789, city: city2})
venue3 = Repo.insert!(%Venue{name: "Wembley Stadium", capacity: 90_000, city: city3})
venue4 = Repo.insert!(%Venue{name: "Staples Center", capacity: 21_000, city: city4})
venue5 = Repo.insert!(%Venue{name: "Mercedes-Benz Stadium", capacity: 71_000, city: city5})
venue6 = Repo.insert!(%Venue{name: "AT&T Stadium", capacity: 100_000, city: city6})
venue7 = Repo.insert!(%Venue{name: "Sydney Opera House", capacity: 5_738, city: city7})
venue8 = Repo.insert!(%Venue{name: "Tokyo Dome", capacity: 55_000, city: city8})
venue9 = Repo.insert!(%Venue{name: "Maracanã Stadium", capacity: 78_838, city: city9})
venue10 = Repo.insert!(%Venue{name: "Allianz Arena", capacity: 75_000, city: city10})
venue11 = Repo.insert!(%Venue{name: "Old Trafford", capacity: 74_140, city: city11})
venue12 = Repo.insert!(%Venue{name: "Signal Iduna Park", capacity: 81_365, city: city7})
venue13 = Repo.insert!(%Venue{name: "San Siro", capacity: 80_018, city: city3})
venue14 = Repo.insert!(%Venue{name: "Camp Nou", capacity: 99_354, city: city2})
venue15 = Repo.insert!(%Venue{name: "Santiago Bernabéu", capacity: 81_044, city: city5})
venue16 = Repo.insert!(%Venue{name: "Anfield", capacity: 53_394, city: city6})
venue17 = Repo.insert!(%Venue{name: "MetLife Stadium", capacity: 82_500, city: city1})
venue18 = Repo.insert!(%Venue{name: "Stamford Bridge", capacity: 40_834, city: city8})
venue19 = Repo.insert!(%Venue{name: "Emirates Stadium", capacity: 60_704, city: city4})
venue20 = Repo.insert!(%Venue{name: "Rose Bowl", capacity: 92_542, city: city1})
venue21 = Repo.insert!(%Venue{name: "Luzhniki Stadium", capacity: 81_000, city: city10})

# concerts
concert1 =
  Repo.insert!(%Concert{
    title: "Utopia Tour",
    venue: venue1,
    conducted_date: Date.from_iso8601!("2020-08-20")
  })

concert2 =
  Repo.insert!(%Concert{
    title: "The After Hours Tour",
    venue: venue2,
    conducted_date: Date.from_iso8601!("2021-09-10")
  })

concert3 =
  Repo.insert!(%Concert{
    title: "Divide World Tour",
    venue: venue3,
    conducted_date: Date.from_iso8601!("2019-07-15")
  })

concert4 =
  Repo.insert!(%Concert{
    title: "Formation World Tour",
    venue: venue4,
    conducted_date: Date.from_iso8601!("2016-04-27")
  })

concert5 =
  Repo.insert!(%Concert{
    title: "Purpose World Tour",
    venue: venue5,
    conducted_date: Date.from_iso8601!("2017-03-25")
  })

concert6 =
  Repo.insert!(%Concert{
    title: "The Eras Tour",
    venue: venue6,
    conducted_date: Date.from_iso8601!("2023-05-05")
  })

concert7 =
  Repo.insert!(%Concert{
    title: "The Monster Ball Tour",
    venue: venue7,
    conducted_date: Date.from_iso8601!("2010-11-23")
  })

concert8 =
  Repo.insert!(%Concert{
    title: "Love On Tour",
    venue: venue8,
    conducted_date: Date.from_iso8601!("2022-04-15")
  })

concert9 =
  Repo.insert!(%Concert{
    title: "Dangerous Woman Tour",
    venue: venue9,
    conducted_date: Date.from_iso8601!("2017-08-12")
  })

concert10 =
  Repo.insert!(%Concert{
    title: "On The Run Tour",
    venue: venue10,
    conducted_date: Date.from_iso8601!("2014-06-25")
  })

concert11 =
  Repo.insert!(%Concert{
    title: "Future Nostalgia Tour",
    venue: venue11,
    conducted_date: Date.from_iso8601!("2022-03-11")
  })

concert12 =
  Repo.insert!(%Concert{
    title: "Map of the Soul Tour",
    venue: venue12,
    conducted_date: Date.from_iso8601!("2022-04-15")
  })

concert13 =
  Repo.insert!(%Concert{
    title: "No Filter Tour",
    venue: venue13,
    conducted_date: Date.from_iso8601!("2021-09-26")
  })

concert14 =
  Repo.insert!(%Concert{
    title: "Justice World Tour",
    venue: venue14,
    conducted_date: Date.from_iso8601!("2023-05-12")
  })

concert15 =
  Repo.insert!(%Concert{
    title: "Divide Tour",
    venue: venue15,
    conducted_date: Date.from_iso8601!("2019-08-25")
  })

concert16 =
  Repo.insert!(%Concert{
    title: "The Man of the Woods Tour",
    venue: venue16,
    conducted_date: Date.from_iso8601!("2018-10-04")
  })

concert17 =
  Repo.insert!(%Concert{
    title: "The 1989 World Tour",
    venue: venue17,
    conducted_date: Date.from_iso8601!("2015-06-30")
  })

concert18 =
  Repo.insert!(%Concert{
    title: "Enigma + Jazz & Piano",
    venue: venue18,
    conducted_date: Date.from_iso8601!("2019-12-28")
  })

concert19 =
  Repo.insert!(%Concert{
    title: "Love on Tour",
    venue: venue19,
    conducted_date: Date.from_iso8601!("2021-09-04")
  })

concert20 =
  Repo.insert!(%Concert{
    title: "On the Run II Tour",
    venue: venue20,
    conducted_date: Date.from_iso8601!("2018-07-14")
  })

concert21 =
  Repo.insert!(%Concert{
    title: "Music of the Spheres World Tour",
    venue: venue21,
    conducted_date: Date.from_iso8601!("2023-04-23")
  })

concertenum = [
  concert1,
  concert2,
  concert3,
  concert4,
  concert5,
  concert6,
  concert7,
  concert8,
  concert9,
  concert10,
  concert11,
  concert12,
  concert13,
  concert14,
  concert15,
  concert16,
  concert17,
  concert18,
  concert19,
  concert20,
  concert21
]

# ConcertSongs
Enum.each(concertenum, fn each ->
  Repo.insert!(%ConcertsSongs{concert: each, song_id: Enum.random(1..11)})
  Repo.insert!(%ConcertsSongs{concert: each, song_id: Enum.random(12..23)})
  Repo.insert!(%ConcertsSongs{concert: each, song_id: Enum.random(24..35)})
  Repo.insert!(%ConcertsSongs{concert: each, song_id: Enum.random(36..47)})
  Repo.insert!(%ConcertsSongs{concert: each, song_id: Enum.random(40..50)})
end)

# Album Embeded Schema
songs = [
  %{
    title: "Moanin'",
    duration: 300
  },
  %{
    title: "Are You Real",
    duration: 290
  },
  %{
    title: "Along Came Betty",
    duration: 372
  },
  %{
    title: "The Drum Thunder Suite",
    duration: 453
  },
  %{
    title: "Blues March",
    duration: 377
  },
  %{
    title: "Come Rain or Come Shine",
    duration: 349
  }
]

producer = %{name: "Art Bakey"}

album =
  AlbumEmbeded.changeset(%AlbumEmbeded{}, %{
    title: "Moanin'",
    producer: producer,
    songs: songs
  })

Repo.insert!(album)

k =
  ArtistProducer.to_changeset(%ArtistProducer{}, %{
    name: "Big Poppa",
    dob: "1998-02-03",
    dod: "2019-09-03",
    role: 3
  })

Enum.each(k, fn val -> Repo.insert!(val) end)

new = %Artist{
  name: "Freddie Mercury",
  dob: Date.from_iso8601!("1946-09-05"),
  dod: Date.from_iso8601!("1991-11-24"),
  grammys_won: 5
}

Repo.insert!(new, on_conflict: :nothing, conflict_target: [:name, :dob, :dod])

Repo.insert!(new,
  on_conflict: [set: [grammys_won: new.grammys_won]],
  conflict_target: [:name, :dob, :dod]
)

# Public Opinions

artist = Repo.get(Artist, 1)
producer = Repo.get(Producer, 1)
concert = Repo.get(Concert, 1)
song = Repo.get(Song, 1)
album = Repo.get(Album, 1)

PublicOpinions.changeset(%PublicOpinions{}, %{
  comment: "The GOAT",
  author: "haks",
  artist: artist
})
|> Repo.insert!()

PublicOpinions.changeset(%PublicOpinions{}, %{
  comment: "Magician",
  author: "someone",
  producer: producer
})
|> Repo.insert!()

PublicOpinions.changeset(%PublicOpinions{}, %{
  comment: "Pleasing",
  author: "someone",
  album: album
})
|> Repo.insert!()

PublicOpinions.changeset(%PublicOpinions{}, %{
  comment: "120 DB!!",
  author: "noone",
  concert: concert
})
|> Repo.insert!()

PublicOpinions.changeset(%PublicOpinions{}, %{comment: "Unique in its genre", author: "anyone", song: song})
|> Repo.insert!()
