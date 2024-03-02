defmodule Proptpl.Base do
  @template_path "priv/statem.tpl"
  @base "Base"
  @tpl_emit_path "test"
  @tpl_emit_basefile "/Base_test.exs"
  @actualsystem "ActualSystem"

  def load_tpl() do
    Proptpl.Tpl.statem()
  end

  def load_para_tpl() do
    Proptpl.Tpl.para_statem()
  end

  # deprecated
  def load_tpl_file() do
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

  # Naming a module for testing
  def mod_name(tpl_str, testfile_name) do
    modify_tpl(tpl_str, @base, testfile_name)
  end

  def actsys_name(tpl_str, actsys_name) do
    modify_tpl(tpl_str, @actualsystem, actsys_name)
  end

  defp modify_tpl(tpl_str, target_token, alt_token) do
    Regex.compile!(target_token)
    |> Regex.replace(tpl_str, alt_token)
  end

  # Emit a testfile to test directory
  def emit_tpl(tpl_str, mod_name, emit_path) do
    name_testfile(mod_name)
    |> change_pathname(emit_path)
    |> print_tpl(tpl_str)
  end

  defp name_testfile(mod_name) do
    String.downcase(mod_name)
  end

  defp change_pathname(new_name, pathname) do
    Regex.compile!(@base)
    |> Regex.replace(pathname, new_name)
  end

  defp print_tpl(fname, tpl_str) do
    File.write(fname, tpl_str)
  end

  def check_path(""), do: default_path()
  def check_path(emit_path) when is_binary(emit_path) do
    emit_path <> @tpl_emit_basefile
  end
  def check_path(_any), do: default_path()

  defp default_path() do
    @tpl_emit_path <> @tpl_emit_basefile
  end
end
