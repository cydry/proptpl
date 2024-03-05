defmodule ProptplTest do
  use ExUnit.Case
  doctest Proptpl

  alias Proptpl.Base
  alias Proptpl.Cli


  test "Naming a module" do
    assert Base.mod_name("defmodule BaseTest", "Named") ==
      "defmodule NamedTest"
  end

  test "Cli parse arguments" do
    assert Cli.parse_args(["Named"]) == {"Named", :nopath, :normal, :nofsm}

    try do
      Cli.parse_args([""])
    catch
      what, value ->
	assert {what,value} ==
	  {:error, %RuntimeError{message: "Bad arguments: Empty module name"}}
    end

    try do
      Cli.parse_args([])
    catch
      what, value ->
	assert {what,value} ==
	  {:error, %RuntimeError{message: "Unexpected arguments: "}}
    end

    try do
      Cli.parse_args(["first","second"])
    catch
      what, value ->
	assert {what,value} ==
	  {:error, %RuntimeError{message: "Unexpected arguments: firstsecond"}}
    end
  end

  test "load_tplfile for stateful test" do
    assert Base.load_tplfile(:normal, :stateful) |> Base.mod_name("Base") |> Base.actsys_name("ActualSystem") ==
      File.read!("priv/statem.txt")
  end

  test "load_tplfile for fsm stateful test" do
    assert Base.load_tplfile(:normal, :fsm) |> Base.mod_name("Base") |> Base.actsys_name("ActualSystem") ==
      File.read!("priv/fsm_statem.txt")
  end
end
