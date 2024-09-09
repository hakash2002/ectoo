defmodule MusicdbRmd.Application do
  @moduledoc """
  Supervisor application starting repo
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MusicdbRmd.Repo
    ]

    opts = [strategy: :one_for_one, name: MusicdbRmd.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
