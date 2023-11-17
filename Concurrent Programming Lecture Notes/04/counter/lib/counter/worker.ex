defmodule Counter.Worker do
  use GenServer

  def start_link(n \\ 0) do
    GenServer.start_link(__MODULE__, n, name: __MODULE__)
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
    {:ok, Counter.Store.get() || n}
  end

  @impl true
  def handle_cast({:inc, amt}, value) do
    Counter.Store.put(value + amt)
    {:noreply, value + amt}
  end

  @impl true
  def handle_cast({:dec, amt}, value) do
    # Counter.Store.put(value - amt)
    {:noreply, value - amt}
  end

  @impl true
  def handle_call(:value, _from, value) do
    {:reply, value, value}
  end

  @impl true
  def terminate(_reason, value) do
    Counter.Store.put(value)
  end

  # just to show how to handle regular messages
  # @impl true
  # def handle_info(:reset, _value) do
  #   {:noreply, 0}
  # end
end
