defmodule Proptpl.Cli do
  def parse_args(argv) do
    OptionParser.parse(argv, aliases: [p: :parallel, f: :fsm],
                             switches: [parallel: :boolean, fsm: :boolean])
    |> check_fsm()
    |> check_parallel()
    |> check_emit_path()
  end

  # Handle fsm(finite state machine) option
  defp check_fsm({[{:fsm, :true} | tail], argv, errors}) do
    {tail, argv, errors, :fsm}
  end

  defp check_fsm({opts, argv, errors}) do
    {opts, argv, errors, :nofsm}
  end

  # Handle parallel option
  defp check_parallel({[parallel: true], argv, errors, fsm_opt}) do
    {:para, argv, errors, fsm_opt}
  end

  defp check_parallel({_other, argv, errors, fsm_opt}) do
    {:normal, argv, errors, fsm_opt}
  end


  # Handle argument specifying directory path where a file will be generated
  defp check_emit_path({emit_type, [module_name, emit_path], _errors, fsm_opt}) do
    {module_name, emit_path, emit_type, fsm_opt}
  end

  defp check_emit_path({_emit_type, [""], _errors, _fsm_opt}) do
    raise "Bad arguments: Empty module name"
  end

  defp check_emit_path({emit_type, [module_name], _errors, fsm_opt}) do
    {module_name, :nopath, emit_type, fsm_opt}
  end

  defp check_emit_path({_emit_type, argv, _errors, _fsm_opt}) do
    raise "Unexpected arguments: #{argv}"
  end
end
