defmodule MusicdbRmd.RepoTest do
  use ExUnit.Case
  alias MusicdbRmd.Repo

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  test "repo connection test" do
    assert {:ok, _something} = Repo.query("SELECT 1")
  end

end
