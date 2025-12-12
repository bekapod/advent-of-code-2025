defmodule AdventOfCode.Day05 do
  defp parse_input(file_name) do
    [fresh_ingredients, available_ingredients] =
      File.read!(file_name)
      |> String.trim()
      |> String.split("\n\n")

    fresh_ingredients =
      fresh_ingredients
      |> String.split("\n")
      |> Enum.map(fn range ->
        range
        |> String.split("-")
        |> then(fn [x, y] -> String.to_integer(x)..String.to_integer(y) end)
      end)

    available_ingredients =
      available_ingredients |> String.split("\n") |> Enum.map(&String.to_integer/1)

    {fresh_ingredients, available_ingredients}
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    {fresh, available} = file_name |> parse_input()

    fresh_and_available_count =
      available
      |> Enum.count(fn avail_ingredient ->
        Enum.any?(fresh, fn fresh_range -> avail_ingredient in fresh_range end)
      end)

    fresh = Enum.sort_by(fresh, & &1.first)

    fresh_count =
      case fresh do
        [] ->
          []

        [first | rest] ->
          Enum.reduce(rest, [first], fn range, [prev | others] = acc ->
            if range.first <= prev.last + 1 do
              merged = prev.first..max(prev.last, range.last)
              [merged | others]
            else
              [range | acc]
            end
          end)
          |> Enum.reverse()
      end
      |> Enum.map(&Range.size/1)
      |> Enum.sum()

    {fresh_and_available_count, fresh_count}
  end
end
