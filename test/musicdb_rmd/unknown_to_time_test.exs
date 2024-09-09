defmodule MusicdbRmd.IntegerTimeTest do
  use ExUnit.Case
  alias MusicdbRmd.UnknownToTime

  test "type test" do
    assert UnknownToTime.type() == :time
  end

  test "dump test" do
    assert UnknownToTime.dump("202") == :error
    assert UnknownToTime.dump(~T[00:12:10]) == {:ok, ~T[00:12:10]}
  end

  test "load test" do
    assert UnknownToTime.load(~T[00:12:10]) == {:ok, 12.1}
    assert UnknownToTime.load("00:12:10") == {:ok, 12.1}
    assert UnknownToTime.load("121") == :error
  end

  test "cast test" do
    assert UnknownToTime.cast("120") == {:ok, ~T[00:02:00]}
    assert UnknownToTime.cast("2.27") == {:ok, ~T[00:02:27]}
    assert UnknownToTime.cast("iuf") == :error

    assert UnknownToTime.cast(120) == {:ok, ~T[00:02:00]}

    assert UnknownToTime.cast(1.20) == {:ok, ~T[00:01:20]}

    assert UnknownToTime.cast(~T[00:12:10]) == {:ok, ~T[00:12:10]}

    assert UnknownToTime.cast("00:12:10") == {:ok, ~T[00:12:10]}

    assert UnknownToTime.cast(%{}) == :error

  end

  test "embed_as test" do
    assert UnknownToTime.embed_as("k") == :dump
  end

  test "equals" do
    assert UnknownToTime.equal?(
             UnknownToTime.cast("120"),
             UnknownToTime.cast(2.0)
           ) == true

    assert UnknownToTime.equal?(
             UnknownToTime.cast("120"),
             UnknownToTime.cast(2.1)
           ) == false
  end
end
