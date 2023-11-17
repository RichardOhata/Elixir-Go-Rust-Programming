defmodule Counter.Worker do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, nil, name: name)
  end

  def inc(name, amt \\ 1) do
    GenServer.cast(name, {:inc, amt})
  end

  def dec(name, amt \\ 1) do
    GenServer.cast(name, {:dec, amt})
  end

  def value(name) do
    GenServer.call(name, :value)
  end

  @impl true
  def init(_) do
    {:ok, 0}
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

  #@impl true
  #def terminate(_reason, value) do
  #  Counter.Store.put(value)
  #end
end
