defmodule Counter.WorkerSupervisor do
  use DynamicSupervisor

  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start_worker(name) do
    DynamicSupervisor.start_child(__MODULE__, {Counter.Worker, name})
  end

  def init(_) do
    DynamicSupervisor.init(strategy: :one_for_one, max_children: 1000)
  end
end
