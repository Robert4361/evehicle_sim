defmodule EvehicleSim.Core.Vehicle do
  alias __MODULE__
  alias EvehicleSim.Core.FileReaders.CsvFileReader
  alias EvehicleSim.Core.VehicleDriveData
  alias EvehicleSim.Core.RadarDriveData
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
  def get_all_radars(),
    do:
      Registry.select(EvehicleSim.RadarRegistry, [
        {{:"$1", :_, :"$2"}, [], [%{name: :"$1", radar: :"$2"}]}
      ])

  @spec start_drive(Vehicle.t()) :: term()
  def start_drive(%Vehicle{drive_data: drive_data} = vehicle) do
    radars =
      get_all_radars()

    drive_data
    |> Enum.each(fn %{latitude: latitude, longitude: longitude, gps_speed: speed} = row ->
      radar = get_closest_radar(radars, latitude, longitude, speed)

      if radar != nil do
        row_for_radar = RadarDriveData.new(vehicle.id, row)
        RadarServer.send_row(radar.name, row_for_radar)
      end
    end)
  end

  defp get_closest_radar(radars, latitude, longitude, speed) do
    radars
    |> Enum.filter(fn radar ->
      GpsDistanceCalculator.calculate_distance_m(
        radar.radar.gps_width,
        radar.radar.gps_length,
        latitude,
        longitude
      ) <= radar.radar.max_distance && speed > radar.radar.max_speed
    end)
    |> List.first()
  end
end
