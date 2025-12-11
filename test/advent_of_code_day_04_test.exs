defmodule AdventOfCodeDay04Test do
  use ExUnit.Case
  doctest AdventOfCode.Day04

  test "solves example" do
    assert AdventOfCode.Day04.solve("inputs/day_04_example.txt") == 13
  end
end
