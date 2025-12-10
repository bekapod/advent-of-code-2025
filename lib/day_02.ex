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

  defp actually_invalid_id?(id) when id < 10, do: false

  defp actually_invalid_id?(id) do
    str_id = Integer.to_string(id)
    len = String.length(str_id)

    1..div(len, 2)
    |> divisors_of(len)
    |> Enum.any?(&is_repeated_pattern?(str_id, len, &1))
  end

  defp divisors_of(range, len) do
    Enum.filter(range, &(rem(len, &1) == 0))
  end

  defp is_repeated_pattern?(str_id, len, pattern_len) do
    pattern = String.slice(str_id, 0, pattern_len)
    String.duplicate(pattern, div(len, pattern_len)) == str_id
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    file_name
    |> parse_input()
    |> Enum.flat_map(fn range -> Enum.filter(range, &invalid_id?/1) end)
    |> Enum.sum()
  end

  @spec actually_solve(String.t()) :: integer()
  def actually_solve(file_name) do
    file_name
    |> parse_input()
    |> Enum.flat_map(fn range -> Enum.filter(range, &actually_invalid_id?/1) end)
    |> Enum.sum()
  end
end
