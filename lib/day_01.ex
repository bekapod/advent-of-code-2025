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

  defp perform_rotation({:R, turns}, value) do
    new_value = rem(value + turns, 100)
    wraps = count_wraps(:R, value, turns)
    {new_value, wraps}
  end

  defp perform_rotation({:L, turns}, value) do
    new_value = rem(rem(value - turns, 100) + 100, 100)
    wraps = count_wraps(:L, value, turns)
    {new_value, wraps}
  end

  defp count_wraps(:R, value, turns), do: div(value + turns, 100)
  defp count_wraps(:L, 0, turns), do: div(turns, 100)
  defp count_wraps(:L, value, turns) when turns >= value, do: 1 + div(turns - value, 100)
  defp count_wraps(:L, _value, _turns), do: 0

  @spec solve(String.t()) :: integer()
  def solve(file_name) do
    parse_input(file_name)
    |> Enum.reduce({50, 0}, fn rotation, {current, count} ->
      case perform_rotation(rotation, current) do
        {0, _wraps} -> {0, count + 1}
        {new_value, _wraps} -> {new_value, count}
      end
    end)
    |> elem(1)
  end

  @spec actually_solve(String.t()) :: integer()
  def actually_solve(file_name) do
    parse_input(file_name)
    |> Enum.reduce({50, 0}, fn rotation, {current, count} ->
      {new_value, wraps} = perform_rotation(rotation, current)
      {new_value, count + wraps}
    end)
    |> elem(1)
  end
end
