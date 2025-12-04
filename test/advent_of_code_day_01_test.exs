defmodule AdventOfCodeDay01Test do
  use ExUnit.Case
  doctest AdventOfCode.Day01

  test "solves example" do
    assert AdventOfCode.Day01.solve("inputs/day_01_example.txt") == 3
  end
end
