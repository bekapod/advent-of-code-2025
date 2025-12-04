defmodule AdventOfCodeDay01Test do
  use ExUnit.Case
  doctest AdventOfCode.Day01

  test "greets the world" do
    assert AdventOfCode.Day01.hello() == :world
  end
end
