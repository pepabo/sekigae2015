defmodule Sekigae do
  @moduledoc """
  席替えスクリプト2015

      $ cat names.txt | elixir sekigae.exs
  """

  @num_lines 2

  def execute(names) do
    :random.seed :os.timestamp

    names |> shuffle |> format
  end

  defp shuffle(names), do: Enum.shuffle(names)

  defp format(names) do
    names
    |> Enum.chunk(@num_lines)
    |> do_format(List.duplicate("", @num_lines))
  end

  defp do_format([], acc), do: acc |> Enum.join("\n")

  defp do_format([verticals | rest], acc) do
    width = (verticals |> Enum.map(&String.length/1) |> Enum.max) + 1

    acc = verticals
      |> Stream.map(&String.ljust &1, width)
      |> Stream.zip(acc)
      |> Stream.map(fn {name, line} -> line <> name end)

    do_format rest, acc
  end
end

defmodule Input do
  def read_all, do: do_read_all []

  defp do_read_all(acc) do
    case IO.gets(:stdio, "") do
      :eof -> acc
      line -> do_read_all [line | acc]
    end
  end
end

Input.read_all
|> Enum.map(&String.strip/1)
|> Sekigae.execute
|> IO.puts
