defmodule Lec4 do
  def create(n) do
    Enum.map(1..n, fn _ -> parent = self();
      spawn(fn -> loop(parent) end) end)
  end

  def all_info(pids) do
    Enum.map(pids, &info/1)
  end

  def info(pid) do
    if Process.alive?(pid) do
      {pid, {:alive, true}, Process.info(pid, :trap_exit),
        Process.info(pid, :links)}
    else
      {pid, {:alive, false}}
    end
  end

  def trap_exit(pid) do
    send(pid, :trap_exit)
  end

  def no_trap_exit(pid) do
    send(pid, :no_trap_exit)
  end

  def link(pid, other) do
    send(pid, {:link, other})
  end

  def loop(parent) do
    receive do
      :trap_exit ->
        Process.flag(:trap_exit, true)
      :no_trap_exit ->
        Process.flag(:trap_exit, false)
      {:link, pid} ->
        Process.link(pid)
      msg = {:EXIT, _from, _reason} ->
        send(parent, {self(), msg})
    end 
    loop(parent)
  end
end

