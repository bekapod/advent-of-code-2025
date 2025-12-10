defmodule AdventOfCodeDay02Test do
  use ExUnit.Case
  doctest AdventOfCode.Day02

  test "solves example" do
    assert AdventOfCode.Day02.solve("inputs/day_02_example.txt") == 1_227_775_554
  end
end
