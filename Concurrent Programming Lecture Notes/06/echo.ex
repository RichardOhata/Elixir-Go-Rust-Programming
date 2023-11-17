defmodule EchoServerActive do
  # active server: incoming data is delivered as a message to the mailbox
  #                of the process that calls accept
  #  disadvantage: no flow control; may overwhelm mailbox            
  def start(port \\ 1234) do
    opts = [:binary, {:packet, 0}, {:reuseaddr, true}]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    spawn(fn -> accept(socket) end)
  end

  def accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    spawn(fn -> accept(socket) end)
    IO.puts("#{inspect(self())}: accepted connection #{inspect(conn)}")
    loop(conn)
  end

  defp loop(socket) do
    receive do
      {:tcp, ^socket, data} ->
        :gen_tcp.send(socket, data)
        loop(socket)
      {:tcp_closed, ^socket} ->
        IO.puts("#{inspect(self())}: connection #{inspect(socket)} closed")
        :gen_tcp.close(socket)
      _ -> :ok
        loop(socket)
    end
  end
end

defmodule EchoServerPassive do
  # passive server: need to call :gen_tcp.recv to receive data
  def start(port \\ 1234) do
    opts = [:binary, {:packet, 0}, {:reuseaddr, true}, {:active, false}]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    spawn(fn -> accept(socket) end)
  end

  def accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    spawn(fn -> accept(socket) end)
    IO.puts("#{inspect(self())}: accepted connection #{inspect(conn)}")
    loop(conn)
  end

  defp loop(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        :gen_tcp.send(socket, data)
        loop(socket)
      {:error, _}  ->
        :gen_tcp.close(socket)
        IO.puts("#{inspect(self())}: connection #{inspect(socket)} closed")
    end
  end
end

defmodule EchoServerHybrid do
  # active once
  def start(port \\ 1234) do
    opts = [:binary, {:packet, 0}, {:reuseaddr, true}, {:active, :once}]
    {:ok, socket} = :gen_tcp.listen(port, opts)
    spawn(fn -> accept(socket) end)
  end

  def accept(socket) do
    {:ok, conn} = :gen_tcp.accept(socket)
    spawn(fn -> accept(socket) end)
    IO.puts("#{inspect(self())}: accepted connection #{inspect(conn)}")
    loop(conn)
  end

  defp loop(socket) do
    receive do
      {:tcp, ^socket, data} ->
        :gen_tcp.send(socket, data)
        :inet.setopts(socket, [{:active, :once}])  # need to reset active once
        loop(socket)
      {:tcp_closed, ^socket} ->
        IO.puts("#{inspect(self())}: connection #{inspect(socket)} closed")
        :gen_tcp.close(socket)
      _ -> :ok
        loop(socket)
    end
  end
end

