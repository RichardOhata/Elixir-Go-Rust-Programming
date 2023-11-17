defmodule ArithmeticServer do
  def start() do
    spawn(&loop/0)
  end

  # client API
  def square(pid, x) do
    send(pid, {self(), :square, x})
    receive do
      {:ok, x} -> x
    end
  end

  def sqrt(pid, x) do
    send(pid, {self(), :sqrt, x})
    receive do
      {:ok, x} -> x
      {:error, reason} -> IO.puts("There was an error: #{reason}")
    end
  end

  defp loop() do
    receive do
      {from, :square, x} ->
        send(from, {:ok, x * x})
      {from, :sqrt, x} ->
        reply =
          if x >= 0,
            do: {:ok, :math.sqrt(x)},
            else: {:error, "square root of negative number"}
        send(from, reply)
    end
    loop()
  end
end

defmodule CounterServer do
  def start(n \\ 0) do
    spawn(fn -> loop(n) end)
  end

  def inc(pid) do
    send(pid, :inc)
  end

  def dec(pid) do
    send(pid, :dec)
  end

  def value(pid) do
    send(pid, {:value, self()})
    receive do
      x -> x
    end
  end

  defp loop(n) do
    receive do
      :inc ->
        loop(n + 1)
      :dec ->
        loop(n - 1)
      {:value, from} ->
        send(from, n)
        loop(n)
    end
  end
end

defmodule RegisteredCounterServer do
  def start(n \\ 0) do
    Process.register(spawn(fn -> loop(n) end), __MODULE__)
  end

  def inc() do
    send(__MODULE__, :inc)
  end

  def dec() do
    send(__MODULE__, :dec)
  end

  def value() do
    send(__MODULE__, {:value, self()})
    receive do
      x -> x
    end
  end

  defp loop(n) do
    receive do
      :inc ->
        loop(n + 1)
      :dec ->
        loop(n - 1)
      {:value, from} ->
        send(from, n)
        loop(n)
    end
  end
end

defmodule UniversalServer do
  def start() do
    spawn(&become/0)
  end

  defp become() do
    receive do
      {:become, f} ->
        f.()
    end
  end

  def fact_server() do
    receive do
      {from, x} -> send(from, fact(x))
    end
    fact_server()
  end

  def fact(0), do: 1
  def fact(n), do: n * fact(n - 1)
end
