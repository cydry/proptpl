defmodule ProptplTest do
  use ExUnit.Case
  doctest Proptpl

  test "greets the world" do
    assert Proptpl.hello() == :world
  end
end
