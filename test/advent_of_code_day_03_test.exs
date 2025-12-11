defmodule AdventOfCodeDay03Test do
  use ExUnit.Case
  doctest AdventOfCode.Day03

  test "solves example" do
    assert AdventOfCode.Day03.solve("inputs/day_03_example.txt", 2) == 357
  end

  test "solves example with 12 banks" do
    assert AdventOfCode.Day03.solve("inputs/day_03_example.txt", 12) == 3_121_910_778_619
  end
end
