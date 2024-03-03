defmodule Proptpl.Cli do
  def parse_args(argv) do
    OptionParser.parse(argv, aliases: [p: :parallel], switches: [parallel: :boolean])
    |> check_parallel()
    |> check_emit_path()
  end

  # Handle parallel option
  defp check_parallel({[parallel: true], argv, errors}) do
    {:para, argv, errors}
  end

  defp check_parallel({_other, argv, errors}) do
    {:normal, argv, errors}
  end


  # Handle argument specifying directory path where a file will be generated
  defp check_emit_path({emit_type, [module_name, emit_path], _errors}) do
    {module_name, emit_path, emit_type}
  end

  defp check_emit_path({emit_type, [module_name], _errors}) do
    {module_name, :nopath, emit_type}
  end

  defp check_emit_path({_emit_type, argv, _errors}) do
    raise "Unexpected arguments: #{argv}"
  end
end
