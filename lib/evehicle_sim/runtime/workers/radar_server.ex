defmodule EvehicleSim.Runtime.Workers.RadarServer do
  use GenServer

  alias EvehicleSim.Core.FileReaders.TxtFileReader
  alias EvehicleSim.Core.Radar

  # client
  def start_link(file_name) do
    case TxtFileReader.open_file(file_name) do
      {:ok, data} ->
        radar = Radar.new(data)
        name = {:via, Registry, {EvehicleSim.RadarRegistry, "radar_#{radar.id}", radar}}

        GenServer.start_link(
          __MODULE__,
          %{max_speed: radar.max_speed, max_duration: radar.max_duration},
          name: name
        )

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec send_row(String.t(), {integer(), EvehicleSim.Core.VehicleDriveData.t()}) :: term()
  def send_row(name, row) do
    via_tuple = {:via, Registry, {EvehicleSim.RadarRegistry, name}}
    GenServer.cast(via_tuple, {:vehicle, row})
  end

  # server
  @impl true
  def init(radar_data) do
    {:ok, radar_data |> Map.put(:start_data, nil) |> Map.put(:end_data, nil)}
  end
end
