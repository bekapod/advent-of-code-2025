defmodule AdventOfCode.Day06 do
  defp parse_input(file_name, cephalopod) when cephalopod == false do
    input =
      File.read!(file_name)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.split(&1))
      |> Enum.reverse()

    [operators | operand_lists] = input

    Enum.zip(
      operators,
      operand_lists
      |> Enum.map(fn operands -> operands |> Enum.map(&String.to_integer/1) end)
      |> Enum.zip_with(& &1)
    )
  end

  defp parse_input(file_name, cephalopod) when cephalopod == true do
    input =
      File.read!(file_name)
      |> String.trim()
      |> String.split("\n")

    {operand_lists, [operators]} = Enum.split(input, -1)

    operand_lists =
      operand_lists
      |> Enum.map(&String.graphemes/1)
      |> Enum.zip_with(& &1)
      |> Enum.chunk_by(fn col -> Enum.all?(col, &(&1 == " ")) end)
      |> Enum.reject(fn group ->
        group |> List.first() |> Enum.all?(&(&1 == " "))
      end)
      |> Enum.map(fn operands ->
        operands
        |> Enum.map(fn operand ->
          operand |> Enum.join("") |> String.trim() |> String.to_integer()
        end)
      end)

    operators = operators |> String.split()

    Enum.zip(
      operators,
      operand_lists
    )
  end

  @spec solve(String.t(), boolean()) :: integer()
  def solve(file_name, cephalopod) do
    file_name
    |> parse_input(cephalopod)
    |> Enum.map(fn {operator, operands} ->
      case operator do
        "*" -> Enum.product(operands)
        "+" -> Enum.sum(operands)
      end
    end)
    |> Enum.sum()
  end
end
