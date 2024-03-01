defmodule ProptplTest do
  use ExUnit.Case
  doctest Proptpl

  alias Proptpl.Base

  test "run the command" do
    assert Proptpl.run() == :ok
  end

  test "Naming a module" do
    assert Base.mod_name("defmodule BaseTest", "Named") ==
      "defmodule NamedTest"
  end
end
