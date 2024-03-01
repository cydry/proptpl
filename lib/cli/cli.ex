defmodule Proptpl.Cli do
  def parse_args(argv) do
    case OptionParser.parse(argv, strict: []) do
      {_parsed, [module_name, emit_path], _errors} ->
	{module_name, emit_path}
      {_parsed, [module_name], _errors} ->
	{module_name, :nopath}
      _ ->
	raise "Unexpected arguments: #{argv}"
    end
  end
end
