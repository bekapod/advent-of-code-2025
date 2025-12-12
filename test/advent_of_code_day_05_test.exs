defmodule AdventOfCodeDay05Test do
  use ExUnit.Case
  doctest AdventOfCode.Day05

  test "solves example" do
    assert AdventOfCode.Day05.solve("inputs/day_05_example.txt") == {3, 14}
  end
end
