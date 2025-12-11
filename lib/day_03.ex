defmodule AdventOfCode.Day03 do
  defp parse_input(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn bank -> bank |> String.graphemes() |> Enum.map(&String.to_integer/1) end)
  end

  @spec solve(String.t(), integer()) :: integer()
  def solve(file_name, max_number_of_banks) do
    file_name
    |> parse_input()
    |> Enum.map(fn bank ->
      Enum.reduce(max_number_of_banks..1//-1, {bank, []}, fn n,
                                                             {remaining_banks, selected_banks} ->
        remaining_banks
        |> Enum.slice(0..-n//1)
        |> Enum.with_index()
        |> Enum.max_by(fn {value, _index} -> value end)
        |> then(fn {value, index} ->
          {Enum.drop(remaining_banks, index + 1), [value | selected_banks]}
        end)
      end)
      |> then(fn {_remaining, selected} -> Enum.reverse(selected) end)
    end)
    |> Enum.map(&Integer.undigits/1)
    |> Enum.sum()
  end
end
