import Config

config :musicdb_rmd, MusicdbRmd.Repo,
  database: "musicdb_rmd",
  username: "postgres",
  password: "2411",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :musicdb_rmd, ecto_repos: [MusicdbRmd.Repo], database: "musicdb_rmd"
