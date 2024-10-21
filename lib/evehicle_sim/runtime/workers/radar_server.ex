defmodule EvehicleSim.Runtime.Workers.RadarServer do
  use GenServer

  alias EvehicleSim.Core.FileReaders.TxtFileReader
  alias EvehicleSim.Core.Radar

  def start_link(file_name) do
    radar =
      TxtFileReader.open_file(file_name)
      |> Radar.new()

    name = {:via, Registry, {EvehicleSim.Registry, radar.id, radar}}

    GenServer.start_link(__MODULE__, nil, name: name)
  end

  @impl true
  def init(_init_arg) do
    {:ok, nil}
  end
end
