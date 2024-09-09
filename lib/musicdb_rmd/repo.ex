defmodule MusicdbRmd.Repo do
  @moduledoc """
  Repo connection
  """
  use Ecto.Repo,
    otp_app: :musicdb_rmd,
    adapter: Ecto.Adapters.Postgres
end
