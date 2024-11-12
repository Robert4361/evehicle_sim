defmodule EvehicleSim.Runtime.Workers.VehicleIdAgent do
  use Agent

  def start_link(_) do
    Agent.start_link(fn -> 1 end, name: __MODULE__)
  end

  def get__and_increment_id() do
    Agent.get_and_update(__MODULE__, fn id -> {id, id + 1} end)
  end
end
