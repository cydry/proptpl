defmodule Proptpl do
  import Proptpl.Base
  import Proptpl.Cli


  def main(argv) do
    parse_args(argv)
    |> emit_testfile()
  end

  def emit_testfile({mod_name, emit_path}) do
    checked_path = check_path(emit_path)

    load_tpl()
    |> mod_name(mod_name)
    |> actsys_name(mod_name)
    |> emit_tpl(mod_name, checked_path)
  end
end
