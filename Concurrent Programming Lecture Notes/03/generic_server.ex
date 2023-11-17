# a server basically spawns a process to execute a loop that
# accepts requests & possibly sends back responses.
# Handling a request can be encapsulated as a function.
# There are 2 types of requests: those that expect a response (calls)
# and those that don't (casts)

# pid = GenericServer.start(ArithServer)
# GenericServer.call()


# pid = CounterServer.start
# CounterServer.inc(pid)
defmodule GenericServer do
  def start(m,  arg \\ nil) do
    spawn(fn -> loop(m, state) end)
  end

  def call(pid, msg) do
    send(pid, {:call, self(), msg})
    receive do
      reply -> reply
    end
  end

  def cast(pid, msg) do
    send(pid, {:cast, msg})
  end

  defp loop(m, state) do
    new_state =
      receive do
        {:call, from, msg} ->
          {reply, new_state} = m.handle_call(msg, state)
          send(from, reply)
          new_state
        {:cast, msg} ->
          m.handle_cast(msg, state)
      end
    loop(m, new_state)
  end
end

defmodule ArithServer do
  # interface
  def start() do
    GenericServer.start(__MODULE__)
  end

  def square(pid, x) do
    GenericServer.call(pid, {:square, x})
  end

  def sqrt(pid, x) do
    GenericServer.call(pid, {:sqrt, x})
  end

  # implementation
  def handle_call({:square, x}, _state) do
    x * x
  end

  def handle_call({:sqrt, x}, _state) do
    if x >= 0, do: :math.sqrt(x), else: :error
  end
end

defmodule CounterServer do
  def start() do
    GenericServer.start(__MODULE__, 0)
  end

  def inc(pid) do
    GenericServer.cast(pid, :inc)
  end

  def dec(pid) do
    GenericServer.cast(pid, :dec)
  end

  def value(pid) do
    GenericServer.call(pid, :value)
  end

  # implementation
  def handle_cast(:inc, state) do
    state + 1
  end

  def handle_cast(:dec, state) do
    state - 1
  end

  def handle_call(:value, state) do
    {state, state}
  end
end
