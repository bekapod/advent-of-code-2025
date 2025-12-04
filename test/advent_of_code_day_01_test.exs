defmodule AdventOfCodeDay01Test do
  use ExUnit.Case
  doctest AdventOfCode.Day01

  test "solves example" do
    assert AdventOfCode.Day01.solve("inputs/day_01_example.txt") == 3
  end

  test "actually solves example" do
    assert AdventOfCode.Day01.actually_solve("inputs/day_01_example.txt") == 6
  end
end
