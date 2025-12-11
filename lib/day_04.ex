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

  defp remove_paper(grid, removed_count, once \\ false)

  defp remove_paper(grid, removed_count, once) do
    new_grid =
      Map.new(grid, fn {{row, col}, cell} ->
        case cell do
          "@" ->
            neighbours_with_paper_count =
              Enum.count(@directions, fn {dr, dc} ->
                Map.get(grid, {row + dr, col + dc}) == "@"
              end)

            new_cell = if neighbours_with_paper_count < 4, do: "x", else: "@"

            {{row, col}, new_cell}

          _ ->
            {{row, col}, cell}
        end
      end)

    newly_removed = Enum.count(new_grid, fn {_position, cell} -> cell == "x" end)

    if newly_removed == 0 or once do
      {removed_count + newly_removed, new_grid}
    else
      reset_grid =
        Map.new(new_grid, fn {position, cell} ->
          {position, if(cell == "x", do: ".", else: cell)}
        end)

      remove_paper(
        reset_grid,
        removed_count + newly_removed
      )
    end
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    {removed_count, _new_grid} = file_name |> parse_input() |> remove_paper(0, true)

    removed_count
  end

  @spec loop_solve(String.t()) :: integer()
  def loop_solve(file_name) do
    {removed_count, _new_grid} = file_name |> parse_input() |> remove_paper(0)

    removed_count
  end
end
