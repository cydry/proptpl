defmodule ProptplTest do
  use ExUnit.Case
  doctest Proptpl

  test "run the command" do
    assert Proptpl.run() == :ok
  end
end
