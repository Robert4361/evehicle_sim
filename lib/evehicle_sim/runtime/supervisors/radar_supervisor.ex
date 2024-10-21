defmodule EvehicleSim.Runtime.Supervisors.RadarSupervisor do
  use DynamicSupervisor

  alias EvehicleSim.Runtime.Workers.RadarServer

  def start_link(_init_arg) do
    DynamicSupervisor.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def start_radar(file_name) do
    DynamicSupervisor.start_child(__MODULE__, {RadarServer, file_name})
  end

  def stop_radar(id) do
    case Registry.lookup(EvehicleSim.Registry, id) do
      [{pid, _data}] -> DynamicSupervisor.terminate_child(__MODULE__, pid)
      [] -> {:error, :not_found}
    end
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
