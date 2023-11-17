defmodule ArithWorker do
  use GenServer

  # client API
  def start() do
    GenServer.start(__MODULE__, nil)  # 2nd arg is passed to init
  end

  def square(pid, x) do
    GenServer.call(pid, {:square, x})
  end

  def sqrt(pid, x) do
    GenServer.call(pid, {:sqrt, x})
  end

  @impl true
  def init(_) do
    {:ok, nil}
  end

  @impl true
  def handle_call({:square, x}, _from, state) do
    {:reply, x * x, state}
  end

  @impl true
  def handle_call({:sqrt, x}, _from, state) do
    reply = if x >= 0, do: :math.sqrt(x), else: :error
    {:reply, reply, state}
  end
end
