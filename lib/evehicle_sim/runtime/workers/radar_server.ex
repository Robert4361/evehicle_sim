defmodule EvehicleSim.Runtime.Workers.RadarServer do
  use GenServer

  alias EvehicleSim.Core.FileReaders.TxtFileReader
  alias EvehicleSim.Core.Radar

  def start_link(file_name) do
    case TxtFileReader.open_file(file_name) do
      {:ok, data} ->
        radar = Radar.new(data)
        name = {:via, Registry, {EvehicleSim.RadarRegistry, "radar_#{radar.id}", radar}}
        GenServer.start_link(__MODULE__, nil, name: name)

      {:error, reason} ->
        {:error, reason}
    end
  end

  @impl true
  def init(_init_arg) do
    {:ok, nil}
  end
end