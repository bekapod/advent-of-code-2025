defmodule AdventOfCodeDay07Test do
  use ExUnit.Case
  doctest AdventOfCode.Day07

  test "solves example" do
    assert AdventOfCode.Day07.solve("inputs/day_07_example.txt") == 21
  end

  test "solves example with timelines" do
    assert AdventOfCode.Day07.solve_timelines("inputs/day_07_example.txt") == 40
  end
end
