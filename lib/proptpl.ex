defmodule Proptpl do
  import Proptpl.Base
  import Proptpl.Cli


  def main(argv) do
    parse_args(argv)
    |> emit_testfile()
  end

  def emit_testfile(mod_name) do
    load_tpl()
    |> mod_name(mod_name)
    |> emit_tpl(mod_name)
  end
end
