defmodule MusicdbRmd.MixProject do
  use Mix.Project

  def project do
    [
      app: :musicdb_rmd,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MusicdbRmd.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.4"},
      {:credo, ">= 0.0.0"}
    ]
  end

  def aliases do
    [
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/adding_datas/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "app.stats": ["ecto.reset", "run priv/repo/statistics/stats.exs"]
    ]
  end
end
