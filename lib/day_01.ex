defmodule AdventOfCode.Day01 do
  defp parse_input(file_name) do
    File.read!(file_name)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn
      <<"L", rest::binary>> -> {:L, String.to_integer(rest)}
      <<"R", rest::binary>> -> {:R, String.to_integer(rest)}
    end)
  end

  defp perform_rotation({:L, turns}, value), do: rem(value - turns + 100, 100)
  defp perform_rotation({:R, turns}, value), do: rem(value + turns, 100)

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    parse_input(file_name)
    |> Enum.reduce({50, 0}, fn rotation, {current, count} ->
      case perform_rotation(rotation, current) do
        0 -> {0, count + 1}
        new_value -> {new_value, count}
      end
    end)
    |> elem(1)
  end
end
