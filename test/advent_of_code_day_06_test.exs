defmodule AdventOfCodeDay06Test do
  use ExUnit.Case
  doctest AdventOfCode.Day06

  test "solves example" do
    assert AdventOfCode.Day06.solve("inputs/day_06_example.txt", false) == 4_277_556
  end

  test "solves cephalopod example" do
    assert AdventOfCode.Day06.solve("inputs/day_06_example.txt", true) == 3_263_827
  end
end
