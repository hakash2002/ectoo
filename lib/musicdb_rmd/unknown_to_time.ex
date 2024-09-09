defmodule MusicdbRmd.UnknownToTime do
  @moduledoc """
  Custom type for :time
  """
  @behaviour Ecto.Type

  def type(), do: :time

  def dump(term = %Time{}), do: Ecto.Type.dump(:time, term)

  def dump(_term), do: :error


  def load(term = %Time{}) do
    %Time{hour: _, minute: m, second: s} = term
    {:ok, String.to_float("#{m}.#{s}")}
  end

  def load(term) when is_binary(term) do
    case Time.from_iso8601(term) do
      {:ok, %Time{hour: _, minute: m, second: s}} ->
        {:ok, String.to_float("#{m}.#{s}")}

      _ ->
        load(:error)
    end
  end

  def load(_term) do
    :error
  end

  def cast(term) when is_integer(term) do
    hours = div(term, 3600)
    minutes = div(rem(term, 3600), 60)
    seconds = rem(term, 60)

    Time.new(hours, minutes, seconds)
  end

  def cast(term) when is_float(term) do
    hours = 0
    minutes = floor(term)
    seconds = ceil((term - minutes) * 100)

    Time.new(hours, minutes, seconds)
  end

  def cast(term) when is_binary(term) do
    case Time.from_iso8601(term) do
      {:ok, time} ->
        {:ok, time}

      {:error, :invalid_format} ->
        casting_binary(term)
    end
  end

  def cast(term = %Time{}), do: {:ok, term}

  def cast(_term), do: :error

  def embed_as(_format), do: :dump

  def equal?(term1, term2) do
    term1 == term2
  end

  defp casting_binary(term) do
    try do
      k = String.to_float(term)
      cast(k)
    rescue
      ArgumentError ->
        try do
          l = String.to_integer(term)
          cast(l)
        rescue
          ArgumentError ->
            :error
        end
    end
  end
end
