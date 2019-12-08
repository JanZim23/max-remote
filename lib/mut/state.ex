defmodule Mut.State do
  use ExActor.Tolerant

  defstart start(code), gen_server_opts: [name: {:via, Registry, {Mut.Registry, code}}] do
    initial_state(%{})
  end

  defcall get(num), state: state do
    Map.get(state, num, "0")
    |> reply()
  end

  defcast put(num, val), state: state do
    state
    |> Map.put(num, val)
    |> new_state()
  end
end
