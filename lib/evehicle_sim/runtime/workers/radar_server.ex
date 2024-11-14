defmodule EvehicleSim.Runtime.Workers.RadarServer do
  use GenServer

  alias EvehicleSim.Core.FileReaders.TxtFileReader
  alias EvehicleSim.Core.Radar
  alias EvehicleSim.Core.RadarDriveData
  alias EvehicleSim.Core.TrafficTicket
  alias EvehicleSim.Runtime.Workers.TicketServer

  # client
  def start_link(file_name) do
    case TxtFileReader.open_file(file_name) do
      {:ok, data} ->
        radar = Radar.new(data)
        radar_name = "radar_#{radar.id}"
        name = {:via, Registry, {EvehicleSim.RadarRegistry, radar_name, radar}}

        GenServer.start_link(
          __MODULE__,
          %{
            max_speed: radar.max_speed,
            max_duration: radar.max_duration,
            name: radar_name
          },
          name: name
        )

      {:error, reason} ->
        {:error, reason}
    end
  end

  @spec send_row(String.t(), RadarDriveData.t()) :: term()
  def send_row(name, row) do
    via_tuple = {:via, Registry, {EvehicleSim.RadarRegistry, name}}
    GenServer.cast(via_tuple, {:vehicle, row})
  end

  # server
  @impl true
  def init(radar_data) do
    {:ok, radar_data |> Map.put(:start_data, nil)}
  end

  @impl true
  def handle_cast({:vehicle, row}, %{start_data: start_data} = radar_information)
      when start_data == nil do
    {:noreply, %{radar_information | start_data: row}}
  end

  @impl true
  def handle_cast({:vehicle, row}, radar_information) do
    start_time = radar_information.start_data.time
    end_time = row.time

    time_between_rows =
      calculate_time_passed_from_milliseconds(start_time, end_time)

    cond do
      time_between_rows >= radar_information.max_duration * 2 ->
        {:noreply, %{radar_information | start_data: nil}}

      time_between_rows < radar_information.max_duration ->
        {:noreply, radar_information}

      time_between_rows >= radar_information.max_duration ->
        ticket =
          TrafficTicket.new(
            row.id,
            start_time,
            end_time,
            row.gps_speed,
            row.latitude,
            row.longitude,
            radar_information.name
          )

        TicketServer.create_ticket(ticket)
        {:noreply, %{radar_information | start_data: nil}}
    end
  end

  defp calculate_time_passed_from_milliseconds(start_time, end_time) do
    (end_time - start_time) / 1000
  end
end
