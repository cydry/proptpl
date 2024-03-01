defmodule Proptpl.Base do
  @template_path "priv/statem.tpl"

  def load_tpl() do
    open_tpl(@template_path)
    |> read_tpl!()
    |> close_tpl
  end

  defp open_tpl(template_path) do
    {:ok, file} = File.open(template_path)
    file
  end

  defp read_tpl!(tpl_file) do
    case IO.read(tpl_file, :eof) do
      {:error, _reason} ->
	raise "Failed to read template file path: #{@template_path}"
      :eof ->
	raise "Empty, template file path: #{@template_path}"
      data ->
	{tpl_file, data}
    end
  end

  defp close_tpl({file, data}) do
    case File.close(file) do
      {:error, posixcd} ->
	raise "Failed to close template file: #{@template_path}, err: #{posixcd}"
      :badargs ->
	raise "Failed to close template file: #{@template_path}, bad file path"
      :teminated ->
	raise "Failed when closing template file"
      :ok ->
	data
    end
  end
end
