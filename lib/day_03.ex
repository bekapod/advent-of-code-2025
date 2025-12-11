defmodule AdventOfCode.Day03 do
  defp parse_input(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn bank -> bank |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    file_name
    |> parse_input()
    |> Enum.map(fn bank ->
      bank
      |> Enum.slice(0..-2//1)
      |> Enum.with_index()
      |> Enum.max_by(fn {value, _index} -> value end)
      |> then(fn {value, index} ->
        next = bank |> Enum.drop(index + 1) |> Enum.max()

        value * 10 + next
      end)
    end)
    |> Enum.sum()
  end

  @spec actually_solve(String.t()) :: integer()
  def actually_solve(file_name) do
    file_name
    |> parse_input()
  end
end
