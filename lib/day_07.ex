defmodule AdventOfCode.Day07 do
  defp parse_input(file_name) do
    {active_beams, splitter_locations} =
      File.read!(file_name)
      |> String.trim()
      |> String.split("\n")
      |> Enum.with_index()
      |> Enum.reduce({MapSet.new(), []}, fn {line, row}, {active_beams, splitter_locations} ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce({active_beams, splitter_locations}, fn {cell, col},
                                                              {beams_acc, splitters_acc} ->
          case cell do
            "S" -> {MapSet.put(beams_acc, col), splitters_acc}
            "^" -> {beams_acc, [{row, col} | splitters_acc]}
            _ -> {beams_acc, splitters_acc}
          end
        end)
      end)

    {active_beams, splitter_locations}
  end

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    {active_beams, splitter_locations} =
      file_name
      |> parse_input()

    splitters_by_row =
      splitter_locations
      |> Enum.group_by(fn {row, _col} -> row end, fn {_row, col} -> col end)
      |> Map.new(fn {row, cols} -> {row, MapSet.new(cols)} end)

    max_row = splitters_by_row |> Map.keys() |> Enum.max()

    {_beams, split_count} =
      0..max_row
      |> Enum.reduce({active_beams, 0}, fn row, {beams, split_count} ->
        splitters_in_row = splitters_by_row[row] || MapSet.new()

        splits_on_this_row =
          beams
          |> Enum.count(fn beam_col ->
            MapSet.member?(splitters_in_row, beam_col)
          end)

        beams =
          beams
          |> Enum.reduce(MapSet.new(), fn beam_col, new_beams ->
            if splitters_in_row |> MapSet.member?(beam_col) do
              new_beams
              |> MapSet.put(beam_col - 1)
              |> MapSet.put(beam_col + 1)
            else
              MapSet.put(new_beams, beam_col)
            end
          end)

        {beams, split_count + splits_on_this_row}
      end)

    split_count
  end

  @spec solve_timelines(String.t()) :: integer()
  def solve_timelines(file_name) do
    {active_beams, splitter_locations} =
      file_name
      |> parse_input()

    beams_map = active_beams |> Enum.map(fn col -> {col, 1} end) |> Map.new()

    splitters_by_row =
      splitter_locations
      |> Enum.group_by(fn {row, _col} -> row end, fn {_row, col} -> col end)
      |> Map.new(fn {row, cols} -> {row, MapSet.new(cols)} end)

    max_row = splitters_by_row |> Map.keys() |> Enum.max()

    0..max_row
    |> Enum.reduce(beams_map, fn row, beams ->
      splitters_in_row = splitters_by_row[row] || MapSet.new()

      beams
      |> Enum.reduce(Map.new(), fn {beam_col, count}, new_beams ->
        if splitters_in_row |> MapSet.member?(beam_col) do
          new_beams
          |> Map.update(beam_col - 1, count, &(&1 + count))
          |> Map.update(beam_col + 1, count, &(&1 + count))
        else
          new_beams |> Map.update(beam_col, count, &(&1 + count))
        end
      end)
    end)
    |> Map.values()
    |> Enum.sum()
  end
end
