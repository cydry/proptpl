defmodule Proptpl.Cli do
  def parse_args(argv) do
    case OptionParser.parse(argv, strict: []) do
      {_parsed, [module_name], _errors} ->
	module_name
      _ ->
	raise "Unexpected arguments: #{argv}"
    end
  end
end
