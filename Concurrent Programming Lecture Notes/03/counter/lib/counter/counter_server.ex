defmodule Counter.Server do
  use GenServer

  def start(n \\ 0) do
    GenServer.start(__MODULE__, n, name: __MODULE__)
  end

  def inc(amt \\ 1) do
    GenServer.cast(__MODULE__, {:inc, amt})
  end

  def dec(amt \\ 1) do
    GenServer.cast(__MODULE__, {:dec, amt})
  end

  def value() do
    GenServer.call(__MODULE__, :value)
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
