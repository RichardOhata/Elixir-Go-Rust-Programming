defmodule Counter.Worker do
  use GenServer

  @name {:global, __MODULE__}

  def start_link(n \\ 0) do
    GenServer.start_link(__MODULE__, n, name: @name)
  end

  def inc(amt \\ 1) do
    GenServer.cast(@name, {:inc, amt})
  end

  def dec(amt \\ 1) do
    GenServer.cast(@name, {:dec, amt})
  end

  def value() do
    GenServer.call(@name, :value)
  end

  @impl true
  def init(n) do
    {:ok, Counter.Store.get() || n}
  end

  @impl true
  def handle_cast({:inc, amt}, value) do
    # Counter.Store.put(value + amt)
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
