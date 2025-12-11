defmodule AdventOfCode.Day04 do
  @directions [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]

  defp parse_input(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, row} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {cell, col} ->
        {{row, col}, cell}
      end)
    end)
    |> Map.new()
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    grid = file_name |> parse_input()

    grid
    |> Enum.filter(fn {_position, cell} -> cell == "@" end)
    |> Enum.count(fn {{row, col}, _cell} ->
      neighbours_with_paper_count =
        Enum.count(@directions, fn {dr, dc} ->
          Map.get(grid, {row + dr, col + dc}) == "@"
        end)

      neighbours_with_paper_count < 4
    end)
  end
end
