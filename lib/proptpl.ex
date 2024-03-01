defmodule Proptpl do
  import Proptpl.Base
  import Proptpl.Cli

  @doc """
  Run world.

  ## Examples

     iex> Proptpl.run()
     :ok
  """
  def run(argv) do
    parse_args(argv)
    |> emit_testfile()
  end

  def emit_testfile(mod_name) do
    load_tpl()
    |> mod_name(mod_name)
    |> emit_tpl(mod_name)
  end
end
