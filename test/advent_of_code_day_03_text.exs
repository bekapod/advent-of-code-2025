defmodule AdventOfCodeDay02Test do
  use ExUnit.Case
  doctest AdventOfCode.Day03

  test "solves example" do
    assert AdventOfCode.Day03.solve("inputs/day_03_example.txt") == 357
  end
end
