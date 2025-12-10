defmodule AdventOfCode.Day02 do
  defp parse_input(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(fn x ->
      x
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)
      |> then(fn [first, last] -> first..last end)
    end)
  end

  defp invalid_id?(id) do
    str_id = Integer.to_string(id)
    len = String.length(str_id)

    rem(len, 2) == 0 and
      str_id
      |> String.split_at(div(len, 2))
      |> then(fn {first, second} -> first == second end)
  end

  defp get_invalid_ids(range) do
    Enum.filter(range, &invalid_id?/1)
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    file_name
    |> parse_input()
    |> Enum.flat_map(&get_invalid_ids/1)
    |> Enum.sum()
  end

  @spec actually_solve(String.t()) :: integer()
  def actually_solve(file_name) do
    parse_input(file_name)
  end
end
