defmodule Counter.Worker do
  use GenServer
  @reg  Counter.Registry
  @tab  Counter.Table

  def start_link(name) do
    GenServer.start_link(__MODULE__, name, name: via(name))
  end

  def inc(name, amt \\ 1) do
    GenServer.cast(via(name), {:inc, amt})
  end

  def dec(name, amt \\ 1) do
    GenServer.cast(via(name), {:dec, amt})
  end

  def value(name) do
    GenServer.call(via(name), :value)
  end

  defp via(name) do
    {:via, Registry, {@reg, {__MODULE__, name}}}
  end

  @impl true
  def init(name) do
    value =
      case :ets.lookup(@tab, name) do
        [{^name, v}] -> v
        _ -> 0
      end
    {:ok, {name, value}}
  end

  @impl true
  def handle_cast({:inc, amt}, {name, value}) do
    {:noreply, {name, value + amt}}
  end

  @impl true
  def handle_cast({:dec, amt}, {name, value}) do
    {:noreply, {name, value - amt}}
  end

  @impl true
  def handle_call(:value, _from, {_, value} = state) do
    {:reply, value, state}
  end

  @impl true
  def terminate(_reason, state) do
    IO.puts("This happened");
    :ets.insert(@tab, state)
  end
end
