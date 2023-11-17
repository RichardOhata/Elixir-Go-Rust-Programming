defmodule Counter do
  def start() do
    :global.register_name(__MODULE__, spawn(fn -> loop(0) end))
  end

  def inc() do
    send(:global.whereis_name(__MODULE__), {:inc, self()})
    receive do
      v -> v
    end
  end

  defp loop(value) do
    receive do
      {:inc, from} ->
        send(from, value + 1)
    end
    loop(value + 1)
  end
end

