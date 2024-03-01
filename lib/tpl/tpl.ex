defmodule Proptpl.Tpl do
  defmodule StateM do
    defstruct tpl: [
      "defmodule BaseTest do\n",
      "  use ExUnit.Case\n",
      "  use PropCheck\n",
      "  use PropCheck.StateM\n",
      "\n",
      "\n",
      "  ### PROPERTIES ###\n",
      "  property \"Stateful Property\", [:verbose] do\n",
      "    forall cmds <- commands(__MODULE__) do\n",
      "      ActualSystem.start_link()\n",
      "      {history, state, result} = run_commands(__MODULE__, cmds)\n",
      "      ActualSystem.stop()\n",
      "\n",
      "      (result == :ok)\n",
      "      |> aggregate(command_names(cmds))\n",
      "      |> when_fail(\n",
      "        IO.puts('''\n",
      "        History: \#{inspect(history)}\n",
      "        State: \#{inspect(state)}\n",
      "        Result: \#{inspect(result)}\n",
      "        ''')\n",
      "      )\n",
      "    end\n",
      "  end\n",
      "\n",
      "\n",
      "  ### MODEL ###\n",
      "  def initial_state(), do: %{}\n",
      "\n",
      "  def command(_state) do\n",
      "    oneof([\n",
      "      {:call, _mod, _fun, _args}\n",
      "    ])\n",
      "  end\n",
      "\n",
      "  def precondition(_state, {:call, _mod, _fun, _args}) do\n",
      "    true\n",
      "  end\n",
      "\n",
      "  def postcondition(_state, {:call, _mod, _fun, _args}, _res) do\n",
      "    true\n",
      "  end\n",
      "\n",
      "  def next_state(state, _res, {:call, _mod, _fun, _args}) do\n",
      "    new_state = state\n",
      "    new_state\n",
      "  end\n",
      "end\n"
    ]
  end

  def statem() do
    %StateM{}.tpl
    |> Enum.join("")
  end
end
