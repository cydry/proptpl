defmodule Proptpl do
  import Proptpl.Base
  import Proptpl.Cli


  def main(argv) do
    parse_args(argv)
    |> emit_testfile()
  end

  def emit_testfile({mod_name, emit_path, emit_type, fsm_opt}) do
    checked_path = check_path(emit_path)

    load_tplfile(emit_type, fsm_opt)
    |> mod_name(mod_name)
    |> actsys_name(mod_name)
    |> emit_tpl(mod_name, checked_path)
  end
end
