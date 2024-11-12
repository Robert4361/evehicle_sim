defmodule EvehicleSim.Core.Vehicle do
  alias __MODULE__
  alias EvehicleSim.Core.FileReaders.CsvFileReader
  alias EvehicleSim.Core.VehicleDriveData
  alias EvehicleSim.Core.GpsDistanceCalculator
  alias EvehicleSim.Runtime.Workers.VehicleIdAgent
  alias EvehicleSim.Runtime.Workers.RadarServer

  @type t :: %Vehicle{
          drive_data: %VehicleDriveData{},
          id: integer()
        }
  defstruct [:id, :drive_data]

  def new(file_name) do
    [_header | data] = CsvFileReader.open_file(file_name)

    %Vehicle{
      id: VehicleIdAgent.get__and_increment_id(),
      drive_data:
        data
        |> Enum.map(&VehicleDriveData.new(&1))
    }
  end

  @spec get_all_radars() :: [%{name: String.t(), radar: %EvehicleSim.Core.Radar{}}]
  defp get_all_radars(),
    do:
      Registry.select(EvehicleSim.RadarRegistry, [
        {{:"$1", :_, :"$2"}, [], [%{name: :"$1", radar: :"$2"}]}
      ])

  def start_simulation(%Vehicle{drive_data: drive_data} = vehicle) do
    radars =
      get_all_radars()
      |> get_radar_name_and_location()

    drive_data
    |> Enum.each(fn %{latitude: latitude, longitude: longitude} = row ->
      radar = get_closest_radar(radars, latitude, longitude)

      if radar != nil do
        RadarServer.send_row(radar.name, {vehicle.id, row})
      end
    end)
  end

  defp get_radar_name_and_location(radars) do
    radars
    |> Enum.map(fn radar ->
      %{
        name: radar.name,
        gps_width: radar.radar.gps_width,
        gps_length: radar.radar.gps_length
      }
    end)
  end

  defp get_closest_radar(radars, latitude, longitude) do
    radars
    |> Enum.filter(fn radar ->
      GpsDistanceCalculator.calculate_distance_m(
        radar.gps_width,
        radar.gps_length,
        latitude,
        longitude
      ) <= radar.max_duration
    end)
    |> List.first()
  end
end
