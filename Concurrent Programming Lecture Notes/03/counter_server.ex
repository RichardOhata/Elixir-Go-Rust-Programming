defmodule CounterServer do
  use GenServer

  def start(n \\ 0) do
    GenServer.start(__MODULE__, n)
  end

  def inc(pid, amt \\ 1) do
    GenServer.cast(pid, {:inc, amt})
  end

  def dec(pid, amt \\ 1) do
    GenServer.cast(pid, {:dec, amt})
  end

  def value(pid) do
    GenServer.call(pid, :value)
  end

  @impl true
  def init(n) do
    {:ok, n}
  end

  @impl true
  def handle_cast({:inc, amt}, state) when is_integer(amt) do
    {:noreply, state + amt}
  end

  @impl true
  def handle_cast({:dec, amt}, state) do
    {:noreply, state - amt}
  end

  @impl true
  def handle_call(:value, _from, state) do
    {:reply, state, state}
  end
end
